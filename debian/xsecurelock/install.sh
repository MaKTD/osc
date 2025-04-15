#!/usr/bin/env bash

apt install xss-lock xsecurelock  -y -qq

if [ -d "/usr/lib/systemd/system-sleep" ]; then
    cp $PWD/xsecurelock_sleep /usr/lib/systemd/system-sleep/xsecurelock_sleep 
else
   echo "/usr/lib/systemd/system-sleep - directory not found, can not install xsecurelock_sleep"
   exit 1
fi

logname=`who am i | awk '{print $1}'`

if [ -d "/home/$logname/.local/bin" ]; then
   cp $PWD/lock_screen /home/$logname/.local/bin/lock_screen
else
   echo "can not install lock_screen alias in ~/.local/bin, directory not found"
   exit 1
fi

echo ""
cat xinitrc_example
