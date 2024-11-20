# bash.bashrc by Arie-SR91
# Copyright 2024 - 2025

shopt -s histappend
shopt -s histverify
export HISTCONTROL=ignoreboth

setpriority(){
  case $2 in
      high) su -c cmd overlay set-priority $1 lowest
            su -c cmd overlay set-priority $1 highest;;
      low) su -c cmd overlay set-priority $1 highest
           su -c cmd overlay set-priority $1 lowest;;
      *) echo "Usage: setpriority overlay [option]"
         echo " "
         echo "Options:"
         echo " high - Sets the overlay to the highest priority"
         echo " low  - Sets the overlay to the lowest priority";;
    esac
}
adbfi(){
  case $1 in
    on) su -c setprop service.adb.tcp.port 5555
        su -c stop adbd
        su -c start adbd
        echo "ADB over WiFi enabled";;
    off) su -c setprop service.adb.tcp.port -1
         su -c stop adbd
         su -c start adbd
         echo "ADB over WiFi disabled";;
    stats) case `getprop service.adb.tcp.port` in -1) echo "off";; 5555) echo "on";; *) echo "off";; esac;;
    *) echo "Usage: adbfi [option]"
       echo " "
       echo "Options:"
       echo " on    - Enables ADB over Wifi"
       echo " off   - Disables ADB over WiFi"
       echo " stats - Gets current status";;
  esac
}

overlays(){
  opt=$1
  [ "$2" ] || opt=null
  case $opt in
    enable) shift
            for i in $(su -c cmd overlay list | grep -iE "^\[.*$1" | sed 's|\[.* ||g'); do su -c cmd overlay enable $i; done;;
    disable) shift
             for i in $(su -c cmd overlay list | grep -iE "^\[.*$1" | sed 's|\[.* ||g'); do su -c cmd overlay disable $i; done;;
    list) shift
          overlayList=$(su -c cmd overlay list | grep -iE "^\[.*$1")
          echo "$overlayList";;
    *) echo "Usage: overlays [option] (keyword)"
       echo " "
       echo "Options:"
       echo " enable  - Enables all overlays that include the keyword in the packagename"
       echo " disable - Disables all overlays that include the keyword in the packagename"
       echo " list    - Lists all overlays that include the keyword in the packagename";;
  esac
}
getperms(){
  su -c pm get-privapp-permissions $1 | sed "s/, /\n/g" 
}
getdenyperms(){
  su -c pm get-privapp-deny-permissions $1 | sed "s/, /\n/g" 
}

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

if [ -f /sdcard/.aliases ]; then
    . /sdcard/.aliases
fi