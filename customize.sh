[ -d /system/xbin ] && BIN=/system/xbin || BIN=/system/bin
if [ -d /sdcard ]; then
  SDCARD=/sdcard
elif [ -d /storage/emulated/0 ]; then
  SDCARD=/storage/emulated/0
fi
set_perm() {
  local uid gid mod;
  uid=$1; gid=$2; mod=$3;
  shift 3;
  chown $uid:$gid "$@" || chown $uid.$gid "$@";
  chmod $mod "$@";
}
ui_print "   Setting $SDCARD location."
sed -i "s|<SDCARD>|$SDCARD|g; s|<BIN>|$BIN|g" $MODPATH/system/etc/bash.bashrc
sed -i "s|<SDCARD>|$SDCARD|g" $MODPATH/system/etc/mkshrc
#sed -i "s|<BIN>|$BIN|g" $MODPATH/custom/.bashrc

set_perm 0 0 755 $MODPATH/system/bin/bash

if [ ! -f $SDCARD/.bash_aliases ]; then
  ui_print "   Copying .bash_aliases to $SDCARD"
  cp $MODPATH/custom/.bash_aliases $SDCARD
else
  ui_print "   $SDCARD/.bash_aliases found! Backing up and overwriting!"
  cp -rf $SDCARD/.bash_aliases $SDCARD/.bash_aliases.bak
  cp -rf $MODPATH/custom/.bash_aliases $SDCARD
fi
if [ ! -f $SDCARD/.bashrc ]; then
  ui_print "   Copying .bashrc to $SDCARD"
  cp $MODPATH/system/etc/bash.bashrc $SDCARD/.bashrc
else
  ui_print "   $SDCARD/.bashrc found! Backing up and overwriting!"
  cp -rf $SDCARD/.bashrc $SDCARD/.bashrc.bak
  cp -rf $MODPATH/system/etc/bash.bashrc $SDCARD/.bashrc
fi
