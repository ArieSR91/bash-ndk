# bash.bashrc by Arie-SR91
# Copyright 2024 - 2025

[ -z "$PS1" ] && return

shopt -s checkwinsize

if [ "$(id -u)" -eq 0 ]; then
    PS1='\u@\h:\w# '
else
    PS1='\u@\h:\w\$ '
fi

if [ ! -f /sdcard/.bashrc ]; then
    cp /etc/skel/.bashrc /sdcard/.bashrc
fi
