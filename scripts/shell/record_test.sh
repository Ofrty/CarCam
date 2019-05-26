#!/bin/sh

vidRes=1024x576

#echo -e "starting to sleep\n"

#sleep 30

#echo -e "sleep done\n"

#with noise gate
avconv -f alsa -ac 1 -thread_queue_size 2048 -i hw:1 -thread_queue_size 2048 -i /dev/video0 -t 15 -threads 4 -async 1 -qscale 8 -sn -y -s $vidRes -aspect 16:9 -af "compand=attacks=0:points=-80/-115|-20.1/-80|0/0|20/20" ~/CarCam/video/_test_${vidRes}_noise_gate.avi

#without noise gate
#avconv -f alsa -ac 1 -thread_queue_size 2048 -i hw:1 -thread_queue_size 2048 -i /dev/video0 -t 15 -threads 4 -async 1 -qscale 2 -sn -y -s $vidRes -aspect 16:9  ~/dashcam/video/_test_${vidRes}.avi
