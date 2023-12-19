FROM ubuntu:20.04

RUN apt update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libgstreamer1.0-dev\
									libgstreamer-plugins-base1.0-dev\
									libgstreamer-plugins-bad1.0-dev\
									gstreamer1.0-plugins-base\
									gstreamer1.0-plugins-good\
									gstreamer1.0-plugins-bad\
									gstreamer1.0-plugins-ugly\
									gstreamer1.0-libav\
									gstreamer1.0-doc\
									gstreamer1.0-tools\
									gstreamer1.0-x\
									gstreamer1.0-alsa\
									gstreamer1.0-gl\
									gstreamer1.0-gtk3
RUN pkg-config --cflags --libs gstreamer-1.0

WORKDIR /app
COPY . /app
ENV RUN_NAME = 20231218053245745784
ENV DISPLAY=host.docker.internal:0
CMD ["/bin/bash", "-c", "gst-launch-1.0 -e multifilesrc location=\"/runs/detect/$RUN_NAME/frames/frames_stream/frame_%d.png\" index=0 caps=\"image/png,framerate=1/100,width=640,height=480\" loop=false ! pngdec ! videorate ! autovideosink sync=false"]
#run
#docker build -t guhzantut/yolov5_live_gst:latest . ; docker run --ipc=host --gpus all -it -v toll_runs:/runs --rm -e RUN_NAME=20231218053245745784 guhzantut/yolov5_live_gst:latest