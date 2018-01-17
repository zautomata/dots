#!/bin/sh
#setxkbmap -option "compose:prsc"
setxkbmap -option "compose:menu"
xrdb -merge ~/.Xresources
exec ssh-agent ratpoison
