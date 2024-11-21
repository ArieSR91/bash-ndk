# bash.bashrc by Arie-SR91
# Copyright 2024 - 2025
case $- in
    *i*) ;;
      *) return;;
esac

shopt -s histverify
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s checkwinsize

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
fi

if [ "$EUID" -eq 0 ]; then
    prompt_color='\[\033[;94m\]'
    info_color='\[\033[1;31m\]'
    pwd_color='\[\033[0m\]'
    prompt_symbol=💀
else
    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    pwd_color='\[\033[0m\]'
    prompt_symbol=㉿
fi

PS1=$prompt_color'┌──('$info_color'\u${prompt_symbol}'$info_color'\h'$prompt_color')-['$pwd_color'\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$ '$pwd_color''

if [ -f /sdcard/.bash_aliases ]; then
    . /sdcard/.bash_aliases
fi
