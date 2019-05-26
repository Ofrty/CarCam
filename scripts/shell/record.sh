#!/bin/sh

################################################################################
#Author:		Joe Kirkham
#Date Created:		2018/09/30
#Description:		This script starts recording a video file of a specified length
#			using the avconv program. GPS metadata is grabbed and temporarily stored
#			as a recording begins. After a recording ends, GPS metadata is added
#			to the file, and a new recording will begin.
#
#			This continues in perpetuity until the script is
#			ended. Some recording parameters (e.g., length, res, filepath, etc)
#			are specified in vars.
#
#			This script derived from GitHub user & project:
#			vijay2552007/CarCam
################################################################################

#vars
filePath=/home/pi/CarCam/video
i=1 #1-indexed. cray cray.
vidRes=1024x576 #should always be a 16x9 aspect ratio
vidTime=30

#infinite loop
while :
do
	#set vars
	curTime=$(date "+%Y-%m-%d__%H.%M.%S")
	fileName=$filePath"dashcam_"$curTime.avi

	#create temp file for GPS info
	touch tempGPS.txt
	./_temp/gps_out.sh > tempGPS.txt

	#get gps info via subshell
	curLat=`cat tempGPS.txt | grep "^Latitude" | tr -s ' ' | cut -d ' ' -f 2`
	curLatRef=`cat tempGPS.txt | grep "^LatRef" | tr -s ' ' | cut -d ' ' -f 2`
	curLon=`cat tempGPS.txt | grep "^Longitude" | tr -s ' ' | cut -d ' ' -f 2`
	curLonRef=`cat tempGPS.txt | grep "^LonRef" | tr -s ' ' | cut -d ' ' -f 2`
	curSpeed=`cat tempGPS.txt | grep "^Speed" | tr -s ' ' | cut -d ' ' -f 2`

	#report current file info
	echo -e "**Starting segment "$i"**\n"
	echo -e "Current Time : "$curTime "\n"
	echo -e "FileName: "$fileName "\n"
	echo -e "Current Latitude: "$curLat $curLatRef "\n"
	echo -e "Current Longitude: "$curLon $curLonRef "\n"
	echo -e "Current Speed: "$curSpeed "\n"

	#This was the toughest part of the whole project to find the optimal settings for recording.
	
	#w/ noise gate; quality 8
	avconv -f alsa -ac 1 -thread_queue_size 2048 -i hw:1 -thread_queue_size 2048 -i /dev/video0 -t $vidTime -threads 4 -async 1 -qscale 8 -sn -y -s $vidRes -aspect 16:9 -af "compand=attacks=0:points=-80/-115|-20.1/-80|0/0/20/20"  $fileName

	#w/o noise gate; quality 2
	#avconv -f alsa -ac 1 -thread_queue_size 2048 -i hw:1 -thread_queue_size 2048 -i /dev/video0 -t $vidTime -threads 4 -async 1 -qscale 2 -sn -y -s $vidRes -aspect 16:9  $fileName

	#noise gate example
	#-af "compand=.1|.1:.2|.2:-900/-900|-50.1/-900|-50/-50:.01:0:-90:.1"

	#set GPS metadata with exempi
	exempi -w $fileName -s exif:GPSLatitude -v $curLat
	exempi -w $fileName -s exif:GPSLatitudeRef -v $curLatRef
	exempi -w $fileName -s exif:GPSLongitude -v $curLon
	exempi -w $fileName -s exif:GPSLongitudeRef -v $curLonRef
	exempi -w $fileName -s exif:GPSSpeed -v $curSpeed
	exempi -w $fileName -s exif:GPSSpeedRef -v M

	#delete tempGPS.txt
	rm tempGPS.txt

	#report end
	echo -e "**Done with segment " $i "**\n\n"

	#increment counter
	((i++))

done
