# RaspBerry Pi CarCam - Ofrty Fork
  This project is forked from GitHub user vijay2552007. See his original README text below. <br> <br>

  I have followed his excellent project instructions on Instructables to create an RPi dashcam. <br> <br>

  My modifications include: <br>
<br> a) Inclusion of a GPS device, in order to tag the video metadata
 <br> b) Recording videos in increments of 30 seconds, in order to ultimately have more GPS data <br> <br>
  <br> c) Modified the avconv command to better suit my setup, and include audio.

  These modifications are reflected in my script. <br> <br>

  Extra notes: <br>
<br> - to set the scheduler, use command "crontab -e" and add the lines per the Instructable's instructions <br> <br> 
<br>
<br>
# vijay2552007 original README 

  The scripts are part of a project - Car RaspBerry pi Dash Cam. Full explanation could be found under <br>
  the instructables website - http://www.instructables.com/id/Car-Raspberry-Pi3-Dash-Cam/. <br> <br>
  
 It Explains about :-
 <br> 1) Hardware/Tools required
  <br> 2) How to connect the components together
   <br> 3) Use the scripts uploaded here
    <br> 4) How to connect to the car
     <br> 5) Perform some testing
