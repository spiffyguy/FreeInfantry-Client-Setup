#!/usr/bin/env playonlinux-bash
# Date : (2022-02-17 07-00)
# Last revision : (2022-02-22 09-07)
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
COMPANY="Free Infantry Group"
DOMAIN="http://www.freeinfantry.com"

POL_SetupWindow_Init
POL_Debug_Init

POL_SetupWindow_presentation "$TITLE" "$COMPANY" "$DOMAIN" "Spiff" "$PREFIX"

POL_System_TmpCreate "$PREFIX"

POL_SetupWindow_InstallMethod "DOWNLOAD,LOCAL"

if [ "$INSTALL_METHOD" = "LOCAL" ]
then
	POL_Wine_SelectPrefix "$PREFIX"
	POL_Wine_PrefixCreate

	POL_SetupWindow_browse "Please select the installation file to run." "$TITLE Installer"
	INSTALLER="$APP_ANSWER"
	
	POL_SetupWindow_wait "Setting up .NET Framework 4.0..." "$TITLE"
	POL_Call POL_Install_dotnet40
	
	POL_SetupWindow_wait "Installing Infantry Online..." "$TITLE"
	
	# Run the installer NOT silently since you chose local and most likely will want to change settings
	POL_Wine "$INSTALLER" /ddraw=opengl
	
elif [ "$INSTALL_METHOD" = "DOWNLOAD" ]
then
	POL_Wine_SelectPrefix "$PREFIX"
	POL_Wine_PrefixCreate

	POL_SetupWindow_wait "Downloading all files first into a temp directory..." "$TITLE"
	cd "$POL_System_TmpDir"
	POL_Download "https://github.com/spiffyguy/Infantry-Online-Client-Setup/releases/download/alpha-test/Install-Infantry-Online-v1.55.0-alpha.exe"
	INSTALLER="$POL_System_TmpDir/Install-Infantry-Online-v1.55.0-alpha.exe"
	
	POL_SetupWindow_wait "Setting up .NET Framework 4.0..." "$TITLE"
	POL_Call POL_Install_dotnet40
	
	POL_SetupWindow_wait "Installing Infantry Online..." "$TITLE"
	
	# Run the installer silently (/S) and override the ddraw renderer to be opengl
	POL_Wine "$INSTALLER" /ddraw=opengl /S
	
fi

# Tell WINE we are overriding the ddraw dll
POL_Wine_OverrideDLL "native, builtin" "ddraw"

POL_Shortcut "InfantryLauncher.exe" "$TITLE" "" "" "Game;MultiplayerGame;"

POL_System_TmpDelete

### Custom: Remove WINE desktop icon
#rm "~/Desktop/$TITLE.desktop"

POL_SetupWindow_Close

exit