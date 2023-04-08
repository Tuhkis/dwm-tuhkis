#!/bin/bash

exec picom &
exec nitrogen --restore

export XDG_CURRENT_DESKTOP="dwm-qol"
exec dwm
