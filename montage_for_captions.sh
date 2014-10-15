#!/bin/sh
#the montage line places top-layer.tif of 1440x1080 size on top of a 1920x1080 lower-layer.tif
#with its upper left corner at XPOS, YPOS  and writes out outfile.tif.   I left a bit of the rest
#of the script in case it's helpful.

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

filein=  etc
fileout= etc
framein= etc
frameout= etc

while [ $framein -le '  --- ' ]

do
   get_leading_zero $framein
   zero_in=$return_zero
   get_leading_zero $frameout
   zero_out=$return_zero

   montage -geometry 1920x1080! lower-layer.tif -draw 'image Over XPOS,YPOS 1440,1080 top-layer.tif' -resize 1920x1080! outfile.tif

   framein=`expr $framein + 1`
   frameout=`expr $frameout + 1`
done

exit
