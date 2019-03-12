#!/bin/bash -x

# get all rtsp address
if [ -e /space/allRtsp.txt ]
then cp /space/allRtsp.txt /home/allRtsp.txt
fi
dos2unix /home/allRtsp.txt;
allRtsp=$(cat /home/allRtsp.txt)

hls="/space/hls/"
log="/space/log/"
i=0
# convert multiple rtsp at once
for rtsp in $allRtsp
do  
    ((i++));
    hlsV=${hls}hls${i}/hls.m3u8;
    logV=${log}log${i}.txt; 
    mkdir ${hls}hls${i}
    nohup ffmpeg -re -i "$rtsp" -c copy -crf 18 -loglevel info -preset veryslow -f hls -hls_time 10.0 -hls_list_size 6 -hls_wrap 10 $hlsV 2>$logV &
done
echo "$i success"