#!/usr/bin/env playonlinux-bash
# Date : (2022-02-17 07-00)
# Last revision : (2022-02-19 17-29)
# Wine version used : 5.0.0
# Distribution used to test : Ubuntu 20.04 LTS
# Author : Spiff
# PlayOnLinux : 4.3.4
# Script license : GPL3
# Program license : Retail

[ "$PLAYONLINUX" = "" ] && exit 0
source "$PLAYONLINUX/lib/sources"

TITLE="Infantry Online"
PREFIX="InfantryOnline"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "Free Infantry Group" "http://www.freeinfantry.com" "Spiff" "$PREFIX"

POL_SetupWindow_question "This will download the latest Infantry Online Launcher from freeinfantry.com and install all needed dependencies. Continue?" "$TITLE"
if [ "$APP_ANSWER" = "TRUE" ]
then
	POL_System_TmpCreate "$PREFIX"
	
	POL_Wine_SelectPrefix "$PREFIX"
	POL_Wine_PrefixCreate
	
	POL_SetupWindow_wait "Downloading all files first into a temp directory..." "$TITLE"
	cd "$POL_System_TmpDir"
	POL_Download "http://freeinfantry.com/Infantry%20Online%20Setup.exe"
	INSTALLER="$POL_System_TmpDir/Infantry%20Online%20Setup.exe"
	POL_Download "https://download1076.mediafire.com/pvpq88idoolg/5owkpgxd37sdqvo/InfantryOnline_cnc-ddraw_4460b_opengl.zip"
	
	# TODO: check that we have everything...
	
	POL_SetupWindow_wait "Setting up .NET Framework 4.0..." "$TITLE"
	
	POL_Call POL_Install_dotnet40
	
	POL_SetupWindow_wait "Follow the screens in the Infantry Online Installer..." "$TITLE"
		
	POL_Wine "$INSTALLER"
	
	POL_SetupWindow_wait "Setting up cnc-ddraw..." "$TITLE"
	
	POL_System_unzip "$POL_System_TmpDir/InfantryOnline_cnc-ddraw_4460b_opengl.zip" -d "$WINEPREFIX/drive_c/Program Files/Infantry Online/"
	
	# Overriding dll
	POL_Wine_OverrideDLL "native, builtin" "ddraw"

	POL_Shortcut "InfantryLauncher.exe" "$TITLE" "" "" "Game;MultiplayerGame;"

	POL_System_TmpDelete
	
	### Custom: Remove WINE desktop icon
	#rm "~/Desktop/$TITLE.desktop"

fi

POL_SetupWindow_Close

exit