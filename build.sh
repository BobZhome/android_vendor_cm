#!/bin/bash

# get current path
reldir=`dirname $0`
cd $reldir
DIR=`pwd`

# Colorize and add text parameters
red=$(tput setaf 1)             #  red
grn=$(tput setaf 2)             #  green
cya=$(tput setaf 6)             #  cyan
txtbld=$(tput bold)             # Bold
bldred=${txtbld}$(tput setaf 1) #  red
bldgrn=${txtbld}$(tput setaf 2) #  green
bldblu=${txtbld}$(tput setaf 4) #  blue
bldcya=${txtbld}$(tput setaf 6) #  cyan
txtrst=$(tput sgr0)             # Reset

THREADS="16"
DEVICE="$1"
SYNC="$2"

# get current version
VERSION_MAJOR=$(cat $DIR/vendor/cm/config/common.mk | grep 'JELLY_BEER_VERSION_MAJOR := *' | sed  's/JELLY_BEER_VERSION_MAJOR := //g')
VERSION_MINOR=$(cat $DIR/vendor/cm/config/common.mk | grep 'JELLY_BEER_VERSION_MINOR := *' | sed  's/JELLY_BEER_VERSION_MINOR := //g')
VERSION_MAINTENANCE=$(cat $DIR/vendor/cm/config/common.mk | grep 'JELLY_BEER_VERSION_MAINTENANCE := *' | sed  's/JELLY_BEER_VERSION_MAINTENANCE := //g')
VERSION=$VERSION_MAJOR.$VERSION_MINOR$VERSION_MAINTENANCE

# get time of startup
res1=$(date +%s.%N)

# we don't allow scrollback buffer
echo -e '\0033\0143'
clear

echo -e "${cya}Building ${bldcya}JellyBeer v$VERSION ${txtrst}";

# sync with latest sources
echo -e ""
if [ "$SYNC" == "true" ]
then
   echo -e "${bldblu}Fetching latest sources ${txtrst}"
   repo sync -j"$THREADS"
   echo -e ""
fi

# delete old builds if it's not a clean build
echo -e "${bldblu}Deleting old builds ${txtrst}"
rm -f $DIR/out/target/product/$DEVICE/JellyBeer*
rm -f $DIR/out/target/product/$DEVICE/system/build.prop
rm -f $DIR/out/target/product/$DEVICE/obj/PACKAGING/target_files_intermediates/cm_$DEVICE-target_files-eng.beerbong/SYSTEM/build.prop
echo -e "${txtrst}Done deleting old builds \n ${txtrst}"

# setup environment
echo -e "${bldblu}Setting up environment ${txtrst}"
export USE_CCACHE=1
. build/envsetup.sh

# brunch device
echo -e ""
echo -e "${bldblu}Brunching device ${txtrst}"
brunch $DEVICE;

# finished? get elapsed time
res2=$(date +%s.%N)
echo "${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"
