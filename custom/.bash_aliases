# .bash_aliases by Arie-SR91
# Copyright 2024 - 2025

alias aflinger='rootcheck && $ROOT dumpsys media.audio_flinger'
alias bb='$BBDIR/busybox'
alias bsu='su -s bash'
alias dservice='rootcheck && $ROOT dumpsys media.dolby_memoryservice'
alias killice='rootcheck && $ROOT killall dk.icepower.icesound'
alias ls='ls --color=auto'
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -l'
alias lo='ls -al'
alias killpac='rootcheck && $ROOT kill $(pidof $1)'
alias sbash='. /system/etc/bash.bashrc'
alias sudo='su -c "$@"'
alias sysro='mount -o remount,ro $@'
alias sysrw='mount -o remount,rw $@'
alias vd='cd'

# Functions which I'm gonna count as aliases
getperms(){ rootcheck && $ROOT pm get-privapp-permissions $1 | sed "s/, /\n/g" 
}
getdenyperms(){ rootcheck && $ROOT pm get-privapp-deny-permissions $1 | sed "s/, /\n/g" 
}
