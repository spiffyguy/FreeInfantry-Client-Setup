#!/usr/bin/env playonlinux-bash
# Date : (2022-02-17 07-00)
# Last revision : (2022-02-17 07-00)
# Wine version used : 6.0.0 # TODO
# Distribution used to test : Ubuntu 20.04 LTS # TODO
# Author : Spiff
# PlayOnLinux : 4.3.4 # TODO
# Script licence : GPL3 # TODO
# Program licence : Retail # TODO

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Infantry Online"
PREFIX="InfantryOnline"

POL_SetupWindow_Init

POL_Debug_Init # TODO: remove when done testing....

POL_SetupWindow_presentation "$TITLE" "Free Infantry Group" "http://www.freeinfantry.com" "Spiff" "$PREFIX"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "LOCAL,DOWNLOAD"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
    POL_SetupWindow_browse "Please select the installation file to run." "$TITLE Installer"
    INSTALLER="$APP_ANSWER"
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
    cd "$POL_System_TmpDir"
    POL_Download "http://freeinfantry.com/Infantry%20Online%20Setup.exe"
    INSTALLER="$POL_System_TmpDir/Infantry Online Setup.exe"
fi

POL_Wine_SelectPrefix "$PREFIX"
POL_Wine_PrefixCreate

POL_SetupWindow_wait "Installation in progress." "$TITLE"
POL_Wine "$INSTALLER"

POL_System_TmpDelete

POL_Shortcut "InfantryLauncher.exe" "Infantry Online"

POL_SetupWindow_Close
exit