#!/bin/bash
# BATOCERA-FIGHTCADE  
###########################################################################
# check if batocera is version 35+ 
kernel=$(uname -a | awk '{print $3}' 2>/dev/null)
if [[ "$kernel" < "5.18" ]]; then 
DISPLAY=:0.0 xterm -fs 10 -fullscreen -fg white -bg black -fa Monospace -en UTF-8 -e bash -c "echo -e \"  █\n  █  ERROR: FIGHTCADE REQUIRES BATOCERA VERSION 35+ \n  █\" & sleep 3" 2>/dev/null && exit 0 & exit 1 & exit 2
fi
###########################################################################
# make directory for fc1 roms 
mkdir -p /userdata/roms/fc1 2>/dev/null
# prepare winesync.sh 
dos2unix /userdata/system/pro/fightcade/extras/winesync.sh 2>/dev/null 
chmod a+x /userdata/system/pro/fightcade/extras/winesync.sh 2>/dev/null 
###########################################################################
# link rom folders for symlinking filesystems 
fs=$(blkid | grep "$(df -h /userdata | awk 'END {print $1}')" | sed 's,^.*TYPE=,,g' | sed 's,",,g' | tr 'a-z' 'A-Z')
#--------------------------------------------------------------------------
 if [[ "$fs" == *"EXT"* ]] || [[ "$fs" == *"BTR"* ]]; 
 then 
#--------------------------------------------------------------------------
#   0) show loading info 
    cp /usr/bin/xterm /usr/bin/loading_fightcade 2>/dev/null && chmod a+x /usr/bin/loading_fightcade 2>/dev/null
    DISPLAY=:0.0 /usr/bin/loading_fightcade -fs 8 -fullscreen -fg black -bg black -fa Monospace -en UTF-8 -e bash -c "echo -e \"\033[0;37mLOADING FIGHTCADE . . .\" & " 2>/dev/null & 
    echo 
    echo -e "  # # #"
    echo -e "  #    "
    echo -e "  #   LINKING ROMS "
    echo -e "  #    "
    echo -e "  # # #"
#--------------------------------------------------------------------------
#   1) link fightcade main ROMs folder 
    rm -rf /userdata/system/pro/fightcade/fightcade/ROMs/Flycast\ ROMs 2>/dev/null
    rm -rf /userdata/system/pro/fightcade/fightcade/ROMs/FBNeo\ ROMs 2>/dev/null
    rm -rf /userdata/system/pro/fightcade/fightcade/ROMs/SNES9x\ ROMs 2>/dev/null
    rm -rf /userdata/system/pro/fightcade/fightcade/ROMs/FC1\ ROMs 2>/dev/null
    mkdir -p /userdata/system/pro/fightcade/fightcade/ROMs 2>/dev/null
    ## ln -s /userdata/roms/dreamcast /userdata/system/pro/fightcade/fightcade/ROMs/Flycast\ ROMs 2>/dev/null
    ln -s /userdata/roms/fbneo /userdata/system/pro/fightcade/fightcade/ROMs/FBNeo\ ROMs 2>/dev/null
    ln -s /userdata/roms/snes /userdata/system/pro/fightcade/fightcade/ROMs/SNES9x\ ROMs 2>/dev/null
    ln -s /userdata/roms/fc1 /userdata/system/pro/fightcade/fightcade/ROMs/FC1\ ROMs 2>/dev/null
#--------------------------------------------------------------------------
#   2) link fightcade emulators ROMs folders 
    rm -rf /userdata/system/pro/fightcade/fightcade/emulator/flycast/ROMs 2>/dev/null
    rm -rf /userdata/system/pro/fightcade/fightcade/emulator/fbneo/ROMs 2>/dev/null
    rm -rf /userdata/system/pro/fightcade/fightcade/emulator/snes9x/ROMs 2>/dev/null
    rm -rf /userdata/system/pro/fightcade/fightcade/emulator/ggpofba/ROMs 2>/dev/null
    ## ln -s /userdata/roms/dreamcast /userdata/system/pro/fightcade/fightcade/emulator/flycast/ROMs 2>/dev/null
    ln -s /userdata/roms/fbneo /userdata/system/pro/fightcade/fightcade/emulator/fbneo/ROMs 2>/dev/null
    ln -s /userdata/roms/snes /userdata/system/pro/fightcade/fightcade/emulator/snes9x/ROMs 2>/dev/null
    ln -s /userdata/roms/fc1 /userdata/system/pro/fightcade/fightcade/emulator/ggpofba/ROMs 2>/dev/null
#--------------------------------------------------------------------------
#   3) link flycast systems&roms = atomiswave/dreamcast/naomi2/naomi 
romdir1="/userdata/system/pro/fightcade/fightcade/ROMs/Flycast ROMs"
romdir2="/userdata/system/pro/fightcade/fightcade/emulator/flycast/ROMs"
rm -rf "$romdir1" 2>/dev/null ; rm -rf "$romdir2" 2>/dev/null
mkdir "$romdir1" 2>/dev/null ; mkdir "$romdir2" 2>/dev/null
fly=/tmp/flycast-roms; rm $fly 2>/dev/null
flymore=/tmp/flycast-more-roms; rm $flymore 2>/dev/null
d1=/userdata/roms/atomiswave
d2=/userdata/roms/dreamcast
d3=/userdata/roms/naomi2
d4=/userdata/roms/naomi
ls $d1 >> $fly ; ls $d2 >> $fly
ls $d3 >> $fly ; ls $d4 >> $fly
nr=$(cat $fly | wc -l) ; n=1
while [[ "$n" -le "$nr" ]]; do
this=$(cat $fly | sed ''$n'q;d')
if [[ -d "$d1/$this" ]]; then 
ln -sf "$d1/$this" "$romdir1/$this" 2>/dev/null;
ln -sf "$d1/$this" "$romdir2/$this" 2>/dev/null; fi
if [[ -d "$d2/$this" ]]; then 
ln -sf "$d2/$this" "$romdir1/$this" 2>/dev/null;
ln -sf "$d2/$this" "$romdir2/$this" 2>/dev/null; fi
if [[ -d "$d3/$this" ]]; then 
ln -sf "$d3/$this" "$romdir1/$this" 2>/dev/null;
ln -sf "$d3/$this" "$romdir2/$this" 2>/dev/null; fi
if [[ -d "$d4/$this" ]]; then 
ln -sf "$d4/$this" "$romdir1/$this" 2>/dev/null;
ln -sf "$d4/$this" "$romdir2/$this" 2>/dev/null; fi
if [[ -f "$d1/$this" ]]; then 
ln -sf "$d1/$this" "$romdir1/$this" 2>/dev/null;
ln -sf "$d1/$this" "$romdir2/$this" 2>/dev/null; fi
if [[ -f "$d2/$this" ]]; then 
ln -sf "$d2/$this" "$romdir1/$this" 2>/dev/null;
ln -sf "$d2/$this" "$romdir2/$this" 2>/dev/null; fi
if [[ -f "$d3/$this" ]]; then 
ln -sf "$d3/$this" "$romdir1/$this" 2>/dev/null;
ln -sf "$d3/$this" "$romdir2/$this" 2>/dev/null; fi
if [[ -f "$d4/$this" ]]; then 
ln -sf "$d4/$this" "$romdir1/$this" 2>/dev/null;
ln -sf "$d4/$this" "$romdir2/$this" 2>/dev/null; fi
if [[ -L "$d1/$this" ]]; then more=1; echo "$d1/$this" >> $flymore; fi
if [[ -L "$d2/$this" ]]; then more=1; echo "$d2/$this" >> $flymore; fi
if [[ -L "$d3/$this" ]]; then more=1; echo "$d3/$this" >> $flymore; fi
if [[ -L "$d4/$this" ]]; then more=1; echo "$d4/$this" >> $flymore; fi
n=$(($n+1))
done
if [[ "$more" = "1" ]]; then
l=/tmp/flycast-more-links; rm $l 2>/dev/null 
nr=$(cat $flymore | wc -l)
n=1
while [[ "$n" -le "$nr" ]]; 
do
this=$(cat $flymore | sed ''$n'q;d')
    if [[ -L "$this" ]]; then 
        ls "$this" >> $l 
        lnr=$(cat $l | wc -l)
        ln=1
        for ln in $(seq 1 $lnr); 
        do
        thisl=$(cat $l | sed ''$ln'q;d')
        #echo "$this/$thisl"
        ln -sf "$this/$thisl" "$romdir1/$thisl" 2>/dev/null;
        ln -sf "$this/$thisl" "$romdir2/$thisl" 2>/dev/null; 
        ln=$(($ln+1))
        done 
    fi
n=$(($n+1))
done 
fi
#--------------------------------------------------------------------------
#   4) link wine stack 
    dos2unix /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null 
    chmod a+x /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null 
    /userdata/system/pro/fightcade/extras/wine.sh 
#--------------------------------------------------------------------------
#   5) add libraries/dependencies 
    cp -rL /userdata/system/pro/fightcade/extras/libatk-bridge-2.0.so.0 /lib/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/extras/libatspi.so.0 /lib/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/extras/libcups.so.2 /lib/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/wine/usr/bin/grep /bin/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/wine/usr/bin/grep /usr/bin/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/wine/usr/bin/xdg* /usr/bin/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/wine/usr/bin/readlink /usr/bin/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/wine/usr/bin/dirname /usr/bin/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/wine/usr/bin/notify-send /usr/bin/ 2>/dev/null
    cp -rL /userdata/system/pro/fightcade/wine/usr/bin/zenity* /usr/bin/ 2>/dev/null
#--------------------------------------------------------------------------
#   6) start fightcade2 
    chmod a+x /userdata/system/pro/fightcade/fightcade/Fightcade2.sh 2>/dev/null
    unclutter-remote -s 
    echo 
    echo -e "  # # #"
    echo -e "  #    "
    echo -e "  #   STARTING FIGHTCADE $(cat /userdata/system/pro/fightcade/fightcade/VERSION.txt)"
    echo -e "  #    "
    echo -e "  # # #"
    /userdata/system/pro/fightcade/fightcade/Fightcade2.sh & 
    /userdata/system/pro/fightcade/extras/syncwine.sh & 
###########################################################################
else # display info that fightcade requires a symlinking filesystem & exit
DISPLAY=:0.0 xterm -fs 10 -fullscreen -fg white -bg black -fa Monospace -en UTF-8 -e bash -c "echo -e \"  █\n  █  ERROR: FIGHTCADE ON BATOCERA REQUIRES A SYMLINKING FILESYSTEM, EXT4 OR BTRFS \n  █\" & sleep 3" 2>/dev/null && exit 0 & exit 1 & exit 2
##-------------------------------------------------------------------------
fi 
