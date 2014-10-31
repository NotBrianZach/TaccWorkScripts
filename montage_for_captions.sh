#!/bin/bash
##the montage line places top-layer.tif of 1440x1080 size on top of a 1920x1080 lower-layer.tif

get_leading_zero() {
   if [ $1 -lt 10 ]; then
      return_zero="000"
   elif [ $1 -ge 10 -a $1 -lt 100 ]; then
      return_zero="00"
   elif [ $1 -ge 100 -a $1 -lt 1000 ]; then
      return_zero="0"
   elif [ $1 -ge 1000 -a $1 -lt 10000 ]; then
      return_zero=""
   fi
   return $return_zero
} 
mon_files=(/home/zachabel/TaccWorkScripts/frames_ParkScene_832x480_dst_02.process/*.jpg)
graph_files=(/home/zachabel/TaccWorkScripts/ok_video/graphs/*.png)

createOverlay(){
  cp $1 ./lowerLayer.jpg
  cp $2 ./topLayer.png
  convert lowerLayer.jpg lowerLayer.tif
  convert topLayer.png topLayer.tif
  
  #to show script progress
  echo $i 
  #montage -geometry 1920x1080! lowerLayer.tif -draw 'image Over 1440,1080 topLayer.tif' -resize 1920x1080! $(printf %04d $i)outFile.tif

  #image Over xpos,ypos,width,height, but gravity readjusts the position
   convert lowerLayer.tif -gravity Northeast -draw "image Over 0,0,300,200 topLayer.tif" $(printf %04d $i)outFile.tif
}

for ((i=0;i<=${#mon_files[@]};i++));
do
    #${#mon_files[@]}
  #echo "${graph_files[i]}"
      createOverlay ${mon_files[i]} ${graph_files[i]}
done
