#!/bin/bash

#********************************************************
#*Author:		 Joe Kirkham
#*Date Created:		2018/09/08
#*Date Modified:	
#*Description: 		This test script simply prints out
#			lat, lon, and speed  info to stdout.
#********************************************************

#read gps data right now; assumption, GPS is already active
raw=$(gpspipe -w -n 10 | grep -m 1 lat)
latStr=lat
lonStr=lon
speedStr=speed

#read latitude
latStartMinusTwo=${raw#*$latStr}
#account for negative
if [ ${latStartMinusTwo:2:1} = "-" ]
then
	lat=${latStartMinusTwo:2:13}
else
	lat=${latStartMinusTwo:2:12}
fi

#read longitude
lonStartMinusTwo=${raw#*$lonStr}
#account for negative
if [ ${lonStartMinusTwo:2:1} = "-" ]
then
	lon=${lonStartMinusTwo:2:13}
else
	lon=${lonStartMinusTwo:2:12}
fi

#read speed
speedStartMinusTwo=${raw#*$speedStr}
speed=${speedStartMinusTwo:2:5}

#print to stdout
echo "Latitude:   " $lat
echo "Longtiude: " $lon
echo "Speed:      " $speed
