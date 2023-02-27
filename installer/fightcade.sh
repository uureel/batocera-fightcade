#!/usr/bin/env bash 
######################################################################
# BATOCERA-FIGHTCADE // FIGHTCADE.BATOCERA.PRO INSTALLER
######################################################################
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
# -- check system before proceeding
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
# prepare paths and files for installation 
cd ~/
killall fc2-electron 2>/dev/null
fightcade=/userdata/system/pro/fightcade; mkdir -p $fightcade/extras 2>/dev/null
tmp=/tmp/batocera-fightcade; rm -rf $tmp 2>/dev/null
# --------------------------------------------------------------------
# -- prepare dependencies for this app and the installer: 
url=https://raw.githubusercontent.com/uureel/batocera-fightcade/main/installer
wget -q -O /lib/libselinux.so.1 $url/libselinux.so.1 2>/dev/null 
wget -q -O /lib/libtinfo.so.6 $url/libtinfo.so.6 2>/dev/null 
wget -q -O /usr/bin/tput $url/tput 2>/dev/null 
wget -q -O /bin/tar $url/tar 2>/dev/null 
chmod a+x /bin/tar 2>/dev/null; chmod a+x /usr/bin/tput 2>/dev/null
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
dl=/userdata/system/pro/fightcade/extras/download
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
size=$(du -h ~/pro/fightcade/extras/download | tail -n 1 | awk '{print $1}' | sed 's,G,,g')
echo -e "DONE, $size GB"
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
echo
echo -e "MERGING . . ."
cd /userdata/system/pro/fightcade/extras/download
cat /userdata/system/pro/fightcade/extras/download/fightcade.tar.xz.parta* >/userdata/system/pro/fightcade/extras/download/fightcade.tar.xz
echo -e "DONE"
#
#/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/
#\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\
#
echo
echo -e "EXTRACTING . . ."
mv /userdata/system/pro/fightcade/extras/download/fightcade.tar.xz /userdata/system/pro/
cd /userdata/system/pro/
tar -xf /userdata/system/pro/fightcade/extra/download/fightcade.tar.xz
cd ~/
rm -rf /userdata/system/pro/fightcade/extras/download 2>/dev/null
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
         rm $tmp2
       echo -e '#!/bin/bash' >> $tmp2
       echo -e "\n$startup \n" >> $tmp2          
       cat "$tmp1" | sed -e '/./b' -e :n -e 'N;s/\n$//;tn' >> "$tmp2"
       cp $tmp2 $csh; dos2unix $csh; chmod a+x $csh  
   else  #(!f csh)   
       echo -e '#!/bin/bash' >> $csh
       echo -e "\n$startup\n" >> $csh  
       dos2unix $csh; chmod a+x $csh  
fi 
dos2unix ~/custom.sh
chmod a+x ~/custom.sh 
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
echo -e "FIGHTCADE INSTALLED. " 
echo 
# done
exit 1 
