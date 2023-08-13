#!/usr/bin/env bash

# More info: https://github.com/chubin/wttr.in

LOCATION=""  # Enter your location here

curl "https://wttr.in/$LOCATION?m0Q&lang=en&format=%22%c%C%20@%20%t%22"
