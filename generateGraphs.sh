#!/bin/bash
#set -x
#DIR=/work/01891/adb/cem/results/tacc_video
DIR=/home/zachabel/tacc/ok_video
mkdir ${DIR}/graphs

#
# gnuplot
#
function createGraph
{
  graphFile=$1
  graphTitle=$2
  datFile=$3
  outFile=$4
  xAxis=$5
  yAxis=$6
  echo $5
  echo ""
  echo ""
  GP_FILE=${graphFile}
  echo "#graph ${graphTitle}" > ${graphFile}
  #echo "set terminal postscript eps enhanced" >> ${GP_FILE}
  echo "set terminal svg" >> ${GP_FILE}
  #echo "set terminal epslatex size 3.5,2.62 standalone color colortext 10" >> ${GP_FILE}
  #echo "set output '${program}_${type}_${compositer}_${source}_${num_triangles}_${threads}.eps'" >> ${GP_FILE}
  echo "set output '${outFile}'" >> ${GP_FILE}
  echo "set size 0.98,1.0" >> ${GP_FILE}
  echo "set datafile missing 'none'" >> ${GP_FILE}
  echo "set key top left" >> ${GP_FILE}
  #echo "unset key" >> ${GP_FILE} 
  # echo "set ytics 10"  >> ${GP_FILE}


  COLOR0="#0060ad"
  COLOR1="#888888"
  COLOR2="#ffb428"
  COLOR3="#28b4ff"
  COLOR4="#333333"
  COLOR5="#ad6000"
  colors=("#0060ad" "#888888" "#ffb428" "#28b4ff" "#333333" "#ad6000")

  COLOR0_1="#ff2068"
  COLOR1_1="#ff8888"
  COLOR2_1="#ff8104"
  COLOR3_1="#ff81aa"
  COLOR4_1="#ff3333"
  COLOR5_1="#adff00"
  counter=1
  echo "set border linewidth 2" >> ${GP_FILE}
  echo "set style line 1 lc rgb '${COLOR0}' linetype 1 linewidth 5" >> ${GP_FILE}

  echo "set xlabel '$xAxis'" >> ${GP_FILE}
  echo "set ylabel '$yAxis'" >> ${GP_FILE}
  echo "set title '$graphTitle'" >> ${GP_FILE}
  # echo "set xrange[1:10]" >> ${GP_FILE}
  # echo "set yrange[0.007:100]" >> ${GP_FILE}
  echo "set grid lc rgb '#aaaaaa'" >> ${GP_FILE}
  echo "set pointsize 0.5" >> ${GP_FILE}
  echo ""
  #ZACH ADDING STUFF 
  #echo "set style line 2 lt 1 lw 1" >> ${GP_FILE}
  #echo "set style arrow 5 nohead ls 1" >> ${GP_FILE}
  echo "set arrow from $7,50 to $7,0" >> ${GP_FILE}
  #echo "set arrow lc rgb 'red'" >> ${GP_FILE}
  echo "show arrow" >> ${GP_FILE}
  #END ZACH ADDED STUFF
  echo -n "plot " >> ${GP_FILE}
  echo -n "'${datFile}' with lines linetype 1 linecolor rgb '${colors[${counter}]}'" >> ${graphFile}
  
    #echo "set terminal postscript eps enhanced" >> ${GP_FILE}
  echo "set terminal svg" >> ${GP_FILE}
  #echo "set terminal epslatex size 3.5,2.62 standalone color colortext 10" >> ${GP_FILE}
  #echo "set output '${program}_${type}_${compositer}_${source}_${num_triangles}_${threads}.eps'" >> ${GP_FILE}
  echo "set output '${outFile}'" >> ${GP_FILE}
  echo "set size 0.98,1.0" >> ${GP_FILE}
  echo "set datafile missing 'none'" >> ${GP_FILE}
  echo "set key top left" >> ${GP_FILE}
  #echo "unset key" >> ${GP_FILE} 
  # echo "set ytics 10"  >> ${GP_FILE}

  
  #examples of ways to automate the color selection if desired
  COLOR0="#0060ad"
  COLOR1="#888888"
  COLOR2="#ffb428"
  COLOR3="#28b4ff"
  COLOR4="#333333"
  COLOR5="#ad6000"
  colors=("#0060ad" "#888888" "#ffb428" "#28b4ff" "#333333" "#ad6000")

  COLOR0_1="#ff2068"
  COLOR1_1="#ff8888"
  COLOR2_1="#ff8104"
  COLOR3_1="#ff81aa"
  COLOR4_1="#ff3333"
  COLOR5_1="#adff00"
  counter=1
  echo "set border linewidth 2" >> ${GP_FILE}
  echo "set style line 1 lc rgb '${COLOR0}' linetype 1 linewidth 5" >> ${GP_FILE}

  #ZACH ADDING STUFF 
  #create a red line
  #echo "plot 9 rgb lc 'red'" >> ${GP_FILE}
  #still need to set the dimensions with variables
  #dst_[0-9][0-9] seems to be the thing to match
  #END ZACH ADDED STUFF
  echo "set xlabel '$xAxis'" >> ${GP_FILE}
  echo "set ylabel '$yAxis'" >> ${GP_FILE}
  echo "set title '$graphTitle'" >> ${GP_FILE}
  # echo "set xrange[1:10]" >> ${GP_FILE}
  # echo "set yrange[0.007:100]" >> ${GP_FILE}
  echo "set grid lc rgb '#aaaaaa'" >> ${GP_FILE}
  echo "set pointsize 0.5" >> ${GP_FILE}
  echo ""
  echo -n "plot " >> ${GP_FILE}
  echo -n "'${datFile}' with lines linetype 1 linecolor rgb '${colors[${counter}]}'" >> ${graphFile}
}

#go through all the files in the directory
  for f in ${DIR}/*.txt
  do
    a=($(wc ${f}))
    frames=${a[0]}#get number of lines in the file (which equals frames we'll need)
    counter=0
    #possibly add another loop right here to count max and min and pass in as parameter to function.
    while [ $counter -le $frames ]
    do
        echo $f  
        datFile=${f}
        shortName=`basename ${f} .txt`
        echo $shortName
        graphFile=${DIR}/graphs/$shortName.gnuplot
        graphTitle=brisque_$shortName
        createGraph $graphFile $graphTitle $datFile ${DIR}/graphs/$shortName.svg frame score $counter
        echo "" >> ${graphFile}
        gnuplot ${graphFile}
        convert ${DIR}/graphs/${shortName}.svg  ${DIR}/graphs/${shortName}.png
    done
  done
