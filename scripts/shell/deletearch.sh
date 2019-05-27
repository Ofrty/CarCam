#!/bin/sh

#wait 1 minute before doing anything, allowing sufficient rPi boot time
sleep 60s

#vars
curTime=$(date "+%Y_%m-%d_%H.%M.%S_UCT%z")
fileLogsName=delete_logs_
fileVideoName=delete_video_
newLogLogName=$fileLogsName$curTime.log		#newly-generated logs to be named with above prefixes + cur datetime
newVideoLogName=$fileVideoName$curTime.log
shelfLifeDays=90
videoExtension=avi

echo -e "***********Running File Archiver***********/n/n"
echo -e "using parameters:/n"
echo -e "/t- current date & time:/t/t$curTime/n"
echo -e "/t- log-deletion log name prefix:/t" "$fileLogsName/n"
echo -e "/t- video-deletion log name prefix:/t" "$fileVideoName/n"
 
#find and delete any extant python or shell .log files created 90+ days ago. append a ny nodw-deleted old logfiles into the newly-created log log
sudo find /home/pi/CarCam/logs/python/ /home/pi/CamProj/logs/shell/ -mtime +$shelfLifeDays -type f -name "*.log" -delete >> /home/pi/CarCam/logs/shell/$newLogLogName 2>&1

#find and delete any videos created 90+ days ago. append any now-deleted old logfiles into the newly-created video log
sudo find /home/pi/CamCam/video/ -mtime +$shelfLifeDays -type f -name "*.$videoExtension" -delete >> /home/pi/CarCam/logs/shell/$newVideoLogName 2>&1

