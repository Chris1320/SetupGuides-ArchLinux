#!/usr/bin/env bash

# Open the webcam's video stream using mpv.

mpv \
    --demuxer-lavf-format=video4linux2 \
    --demuxer-lavf-o-set=input_format=mjpeg \
    --profile=low-latency \
    --untimed \
    av://v4l2:/dev/video0
