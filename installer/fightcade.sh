#!/usr/bin/env bash 
######################################################################
# BATOCERA-FIGHTCADE // FIGHTCADE.BATOCERA.PRO INSTALLER
######################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# -- check system before proceeding
clear; echo
kernel=$(uname -a | awk '{print $3}' 2>/dev/null)
if [[ "$kernel" < "5.18" ]]; then 
echo -e "${RED}ERROR: THIS SYSTEM IS NOT SUPPORTED"
echo -e "${RED}YOU NEED BATOCERA VERSION 35+"
sleep 3
exit 0; exit 1; exit 2
fi 
free=$(df -h | grep "userdata" | awk '{print $4}' | sed 's,G,,g' | cut -d "." -f1)
if [[ "$free" -le "4" ]]; then 
echo -e "${RED}ERROR: YOU NEED AT LEAST 4GB OF FREE DISK SPACE ON /USERDATA "
echo -e "${RED}YOU HAVE $free GB"
sleep 3
exit 0; exit 1; exit 2
fi 
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
spinner()
{
    local pid=$1
    local delay=0.2
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf "PLEASE WAIT . . .  %c   " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
    done
    printf "   \b\b\b\b"
}
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# prepare paths and files for installation 
cd ~/
killall fc2-electron 2>/dev/null
fightcade=/userdata/system/pro/fightcade; mkdir -p $fightcade/extras 2>/dev/null
tmp=/tmp/batocera-fightcade; rm -rf $tmp 2>/dev/null
# --------------------------------------------------------------------
# -- prepare dependencies for this app and the installer: 
url=https://raw.githubusercontent.com/uureel/batocera-fightcade/main/installer
wget -q -O $tmp/installer.sh $url/fightcade.sh 2>/dev/null 
dos2unix $tmp/installer.sh 2>/dev/null; chmod a+x $tmp/installer.sh 2>/dev/null
wget -q -O /lib/libselinux.so.1 $url/libselinux.so.1 2>/dev/null 
wget -q -O /bin/tar $url/tar 2>/dev/null; chmod a+x /bin/tar 2>/dev/null
# --------------------------------------------------------------------
# show console info: 
clear
echo -e "--------------------------------------------------------"
echo -e "--------------------------------------------------------"
echo -e ""
echo -e "BATOCERA.PRO/FIGHTCADE INSTALLER"
echo -e ""
echo -e "--------------------------------------------------------"
echo -e "--------------------------------------------------------"
echo
# --------------------------------------------------------------------
sleep 0.33
echo -e "THIS WILL INSTALL BATOCERA-FIGHTCADE"
echo -e "WITH ALL NECESSARY DEPENDENCIES"
echo
echo -e "FIGHTCADE WILL BE AVAILABLE IN PORTS AND F1->APPLICATIONS "
echo -e "AND INSTALLED IN /USERDATA/SYSTEM/PRO/FIGHTCADE"
echo
sleep 3
echo
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
# -- download the package 
# -- set temp for curl download
dl=/userdata/system/pro/fightcade/extras/downloads
rm -rf $dl 2>/dev/null; mkdir $dl 2>/dev/null; cd $dl 
echo
echo -e "DOWNLOADING FIGHTCADE [1/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partaa
echo -e "DOWNLOADING FIGHTCADE [2/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partab
echo -e "DOWNLOADING FIGHTCADE [3/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partac
echo -e "DOWNLOADING FIGHTCADE [4/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partad
echo -e "DOWNLOADING FIGHTCADE [5/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partae
echo -e "DOWNLOADING FIGHTCADE [6/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partaf
echo -e "DOWNLOADING FIGHTCADE [7/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partag
echo -e "DOWNLOADING FIGHTCADE [8/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partah
echo -e "DOWNLOADING FIGHTCADE [9/9] . . ."
curl --progress-bar --remote-name --location https://github.com/uureel/batocera-fightcade/raw/main/package/fightcade.tar.gz.partai
#
# check downloads integrity 
p1=$dl/fightcade.tar.gz.partaa
p2=$dl/fightcade.tar.gz.partab
p3=$dl/fightcade.tar.gz.partac
p4=$dl/fightcade.tar.gz.partad
p5=$dl/fightcade.tar.gz.partae
p6=$dl/fightcade.tar.gz.partaf
p7=$dl/fightcade.tar.gz.partag
p8=$dl/fightcade.tar.gz.partah
p9=$dl/fightcade.tar.gz.partai
if [[ -f "$p1" ]] && [[ -f "$p2" ]] && [[ -f "$p3" ]] && [[ -f "$p4" ]] && [[ -f "$p5" ]] && [[ -f "$p6" ]] && [[ -f "$p7" ]] && [[ -f "$p8" ]] && [[ -f "$p9" ]]; 
    then 
    p1m=$(md5sum $p1 | awk '{print $1}')
    p2m=$(md5sum $p2 | awk '{print $1}')
    p3m=$(md5sum $p3 | awk '{print $1}')
    p4m=$(md5sum $p4 | awk '{print $1}')
    p5m=$(md5sum $p5 | awk '{print $1}')
    p6m=$(md5sum $p6 | awk '{print $1}')
    p7m=$(md5sum $p7 | awk '{print $1}')
    p8m=$(md5sum $p8 | awk '{print $1}')
    p9m=$(md5sum $p9 | awk '{print $1}')
    if [[ "$p1m" = "38e21dc62048b23cbe43d6de0914f97f" ]] && [[ "$p2m" = "5c601b1608990d12191ae33d301b2ca0" ]] && [[ "$p3m" = "12ccf39c925d1e12783acae2aa957490" ]] && [[ "$p4m" = "0381e60bf464ae2796ccbc50e60a9488" ]] && [[ "$p5m" = "2b0ac3ed77b469e2c2fcc983707a824c" ]] && [[ "$p6m" = "8ec9ec1d0a53718f2a89fc43c90d275a" ]] && [[ "$p7m" = "4bda7b29153e3445fe23df4b1a4b5707" ]] && [[ "$p8m" = "e2cfec24628e1a63c2232e79a81251e6" ]] && [[ "$p9m" = "8a94799487624e81c3419df0346b2450" ]]; 
        then 
            #
            size=$(du -h ~/pro/fightcade/extras/downloads | tail -n 1 | awk '{print $1}' | sed 's,G,,g')
            echo -e "DONE, $size GB"
        else 
            echo
            echo -e "DOWNLOAD WENT BAD! ;( "
            sleep 2
            echo -e "RESTARTING INSTALLER . . ."
            sleep 3
            exit 0 & /tmp/batocera-fightcade/installer.sh 
    fi
fi
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
echo
echo -e "MERGING . . ."
cd /userdata/system/pro/fightcade/extras/downloads
cat /userdata/system/pro/fightcade/extras/downloads/fightcade.tar.gz.parta* >/userdata/system/pro/fightcade/extras/downloads/fightcade.tar.gz
echo -e "DONE,"
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
echo
echo -e "EXTRACTING. . . ."
cd /userdata/system/pro/
mv /userdata/system/pro/fightcade/extras/downloads/fightcade.tar.gz /userdata/system/pro/
tar -xf /userdata/system/pro/fightcade.tar.gz & spinner $! 
rm -rf /userdata/system/pro/fightcade/extras/downloads 2>/dev/null
size=$(du -h ~/pro/fightcade | tail -n 1 | awk '{print $1}' | sed 's,G,,g')
echo -e "$size GB"
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
echo
echo -e "INSTALLING . . ."
#
# check d2u/a+x 
dos2unix /userdata/system/pro/fightcade/extras/startup.sh 2>/dev/null
dos2unix /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null
dos2unix /userdata/system/pro/fightcade/Fightcade2.sh 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/extras/startup.sh 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/extras/wine.sh 2>/dev/null
chmod a+x /userdata/system/pro/fightcade/Fightcade2.sh 2>/dev/null
/userdata/system/pro/fightcade/extras/startup.sh 2>/dev/null
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# -------------------------------------------------------------------
# ADD TO BATOCERA AUTOSTART > /USERDATA/SYSTEM/CUSTOM.SH TO ENABLE F1
# -------------------------------------------------------------------
#
csh=/userdata/system/custom.sh; dos2unix $csh
startup="/userdata/system/pro/fightcade/extras/startup.sh"
if [[ -f $csh ]];
   then
      tmp1=/tmp/tcsh1
      tmp2=/tmp/tcsh2
      remove="$startup"
      rm $tmp1 2>/dev/null; rm $tmp2 2>/dev/null
      nl=$(cat "$csh" | wc -l); nl1=$(($nl + 1))
         l=1; 
         for l in $(seq 1 $nl1); do
            ln=$(cat "$csh" | sed ""$l"q;d" );
               if [[ "$(echo "$ln" | grep "$remove")" != "" ]]; then :; 
                else 
                  if [[ "$l" = "1" ]]; then
                        if [[ "$(echo "$ln" | grep "#" | grep "/bin/" | grep "bash" )" != "" ]]; then :; else echo "$ln" >> "$tmp1"; fi
                     else 
                        echo "$ln" >> $tmp1;
                  fi
               fi            
            ((l++))
         done
         # 
         rm $tmp2 2>/dev/null
           echo -e '#!/bin/bash' >> $tmp2
           echo -e "\n$startup " >> $tmp2          
           cat "$tmp1" | sed -e '/./b' -e :n -e 'N;s/\n$//;tn' >> "$tmp2"
           cp $tmp2 $csh 2>/dev/null; dos2unix $csh 2>/dev/null; chmod a+x $csh 2>/dev/null  
   else  #(!f csh)   
       echo -e '#!/bin/bash' >> $csh
       echo -e "\n$startup\n" >> $csh  
       dos2unix $csh 2>/dev/null; chmod a+x $csh 2>/dev/null  
fi 
dos2unix ~/custom.sh 2>/dev/null
chmod a+x ~/custom.sh 2>/dev/null
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# add Fightcade2 to ports
cp /userdata/system/pro/fightcade/Fightcade2.sh /userdata/roms/ports/Fightcade2.sh 2>/dev/null
# add pad2key 
url=https://raw.githubusercontent.com/uureel/batocera-fightcade/main/installer
wget -q -O /userdata/roms/ports/Fightcade2.sh.keys $url/Fightcade2.sh.keys 2>/dev/null 
# reload gamelists 
curl http://127.0.0.1:1234/reloadgames 
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# finished installing // 
echo 
echo -e "FIGHTCADE INSTALLED :) " 
echo 
# done
exit 1 
