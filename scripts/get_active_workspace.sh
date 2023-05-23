#!/usr/bin/env bash

# return the number of the active workspace.

hyprctl activeworkspace | head -n 1 | cut -d ' ' -f 3
