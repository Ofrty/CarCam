#!/bin/sh

#vars
filePath=/home/pi/dashcam/video/
i=1 #1-indexed. cray cray.
vidRes=1024x576

#infinite loop
while :
do
	#set vars
	curTime=$(date "+%Y-%m-%d__%H.%M.%S")
	fileName=$filePath"dashcam_"$curTime.avi
   	
	#report current file info
	echo -e "**Starting segment # "$i"**\n"
	echo -e "Current Time : "$curTime"\n"
	echo -e "FileName: "$fileName"\n"
	
	#This was the toughest part of the whole project to find the optimal settings for recording.
	avconv -f alsa -ac 1 -thread_queue_size 2048 -i hw:1 -thread_queue_size 2048 -i /dev/video0 -t 30 -threads 4 -async 1 -qscale 2 -sn -y -s $vidRes -aspect 16:9 $fileName

	#report end
	echo -e "**Done with segment #" $i "**\n\n"

	#increment counter
	((i++))

done
 
