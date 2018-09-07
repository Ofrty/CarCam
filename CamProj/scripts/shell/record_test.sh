#!/bin/sh

vidRes=1024x576

avconv -f alsa -ac 1 -thread_queue_size 2048 -i hw:1 -thread_queue_size 2048 -i /dev/video0 -t 30 -threads 4 -async 1 -qscale 2 -sn -y -s $vidRes -aspect 16:9 ~/dashcam/video/_test_${vidRes}.avi
