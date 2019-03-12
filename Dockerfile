
# FROM nginx
# WORKDIR /home
# COPY ./ /home
# RUN cp mime.types nginx.conf /etc/nginx/
# RUN apt update && apt install ffmpeg -y
# RUN apt install dos2unix && dos2unix hls.sh allRtsp.txt && chmod +x ./hls.sh && mkdir ./space
# CMD  ./hls.sh && nginx -g 'daemon off;'

FROM nginx
WORKDIR /home
COPY ./ /home
# config nginx
RUN cp mime.types nginx.conf /etc/nginx/
# 
RUN apt-get update --fix-missing 
RUN apt-get install ffmpeg -y
RUN apt-get install dos2unix && dos2unix hls.sh allRtsp.txt && chmod +x hls.sh
# create two folder to save converting log and converted rtsp
RUN mkdir /space /space/log /space/hls
CMD /home/hls.sh && nginx -g 'daemon off;'