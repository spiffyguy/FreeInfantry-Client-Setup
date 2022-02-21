# Author : Spiff
# Date : (2022-02-21 09-00)
# Last revision : (2022-02-21 11-48)

!define APPNAME "Infantry Online"
!define COMPANYNAME "Free Infantry Group"
!define DESCRIPTION "Infantry is an online-only multiplayer action game with a science fiction theme. Players can spectate or join one of multiple game types running simultaneously, and communicate through an in-game chat window."

!define VERSIONMAJOR 1
!define VERSIONMINOR 55
!define VERSIONBUILD 0

!define HELPURL "https://discord.gg/2avPSyv" # "Support Information" link
!define UPDATEURL "http://www.freeinfantry.com" # "Product Updates" link
!define ABOUTURL "http://www.freeinfantry.com" # "Publisher" link

#TODO: need to confirm this size...
!define INSTALLSIZE 5940

RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)

InstallDir "$PROGRAMFILES\${APPNAME}"

LicenseData "_assets/License.rtf"

Name "${APPNAME} - ${COMPANYNAME}"
Icon "_builds\launcher\imgs\infantry.ico"
outFile "_builds\installer\Install-Infantry-Online.exe"

!include LogicLib.nsh

page license
page directory
Page instfiles

!macro VerifyUserIsAdmin
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
        MessageBox mb_iconstop "Administrator rights required!"
        SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        Quit
${EndIf}
!macroend

function .onInit
	setShellVarContext all
	StrCpy $INSTDIR "$PROGRAMFILES\${APPNAME}"
	!insertmacro VerifyUserIsAdmin
functionEnd

section "install"

	setOutPath $INSTDIR

	#############
	#	Files - Main Infantry Launcher
	#############
	File "_builds\launcher\InfantryLauncher.exe"
	File "_builds\launcher\Newtonsoft.Json.dll"
	File "_builds\launcher\default.ini"
	File /r "_builds\launcher\imgs"
	
	#############
	#	Files - CNC-DDraw
	#############
	File "_builds\cnc-ddraw\ddraw.dll"
	File "_builds\cnc-ddraw\ddraw.ini"
	File "_builds\cnc-ddraw\cnc-ddraw config.exe"
	File /r "_builds\cnc-ddraw\Shaders"
	
	#############
	#	Registry - LAUNCHER
	#############
 	WriteRegStr HKCU "Software\HarmlessGames\Infantry\Launcher" "Path" "$INSTDIR"
 	WriteRegStr HKCU "Software\HarmlessGames\Infantry\Launcher" "Version" "2.1.0.9"

	#############
	#	Registry - MISC
	#############
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "Accepted" 0x00000000
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "BL" 0x00000000
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "BP" 0x00000000
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "GlobalNewsCrc" 0x00000000
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "HighPriority" 0x00000000
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "LastProfile" 0x00000000
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "LastVersionExecuted" 0x0000009b
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "ReleaseNotesCrc" 0x00000000
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "SC" 0x00000000
	WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Misc" "ST" 0x00000000
	 
	#############
	#	Registry - PROFILES
	#############
 
	# (This loops 6 times.... Profile5,Profile4,Profile3,Profile2,Profile1,Profile0)
	${ForEach} $1 5 0 - 1
		
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel0" "newbies"
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel1" ""
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel2" ""
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel3" ""
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel4" ""
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel5" ""
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel6" ""
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel7" ""
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel8" ""
		
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\HiddenOptions" "ZoomMax" 0x000003e8
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\HiddenOptions" "ZoomTime" 0x00000064

 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "0" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "1" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "10" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "11" 0x00040000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "12" 0x00100000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "13" 0x00080000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "14" 0x01440000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "15" 0x01140000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "16" 0x00440000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "17" 0x01480000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "18" 0x01180000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "19" 0x00800000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "2" 0x015c0000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "20" 0x011c0000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "21" 0x01200000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "22" 0x00900000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "23" 0x01200000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "24" 0x01500000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "25" 0x01640000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "26" 0x01540000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "27" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "28" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "29" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "3" 0x014c0000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "30" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "31" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "32" 0x00480000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "33" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "34" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "35" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "36" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "37" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "38" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "39" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "4" 0x00c40000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "40" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "41" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "42" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "43" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "44" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "45" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "46" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "47" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "48" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "49" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "5" 0x00c80000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "50" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "51" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "52" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "53" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "54" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "55" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "56" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "57" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "58" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "59" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "6" 0x01040000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "60" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "61" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "62" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "63" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "64" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "65" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "66" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "67" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "68" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "69" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "7" 0x01100000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "8" 0x0040ae00
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "9" 0x0040a600
 		
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "AxisDeadzone" 0x00001f40
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "AxisRotate" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "AxisStrafe" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "AxisThrust" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "EnterForMessages" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "LeftRight" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "MouseLeft" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "MouseMiddle" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "MouseRight" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "MovementMode" 0x00000003

 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "ReservedFirstLetters" "~ `+-"

 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "Alarm" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "Entering" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterChat" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterKill" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterPopup" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterPrivate" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterPublic" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterPublicMacro" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterSquad" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterSystem" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterTeam" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "FixCase" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "Height" 0x00000054
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "Leaving" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Message" "NameWidth" 0x00000054

 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "AdjustSoundDelay" 0x00000005
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "AlternateClock" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "AutoLogMessages" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "AvoidPageFlipping" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "BannerCacheSize" 0x000001f4
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "BlockObscene2" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ChatChannelEntering" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "CoordinateMode" 0x00000003
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "DeathMessageMode" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "DetailLevel" 0x00000002
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "DisableJoystick" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "DisplayLosAlpha" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "DisplayLosMode" 0x00000002
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "DisplayMapGrid" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "EnergyPercent" 0x00000258
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "EnvironmentAudio" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "FakeAlpha" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "HideSmartTrans" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "IsAllowSpectators" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "MainRectBottom" 0x000004af
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "MainRectLeft" 0x00000026
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "MainRectRight" 0x0000041c
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "MainRectTop" 0x00000278
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "NotepadLastWidth" 0x000000a0
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "NotepadWidth" 0x000000a0
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "PlayerListHeightPercent" 0x00000db2
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "PlayerSortMode" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "RadarGammaPercent" 0x000003e8
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "RenderBackground" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "RenderParallax" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "RenderStarfield" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ResolutionX" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ResolutionY" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "RollMode" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "RotateRampTime" 0x00000019
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "RotationCount" 0x00000040
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "RotationSounds" 0x00000001
 		
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "SDirectoryAddress" "infdir1.aaerox.com"
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "SDirectoryAddressBackup" "infdir2.aaerox.com"

 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowAimingTick" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowBallTrails" 0x000001f4
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowBanners" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowClock" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowDifficultyLevel" 0x00000064
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowEnemyThrust" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowEnergyBar" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowFrameRate" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowHealthGuage" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowKeystrokes" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowLogo" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowMessageType" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowPhysics" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowSelfName" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowTerrain" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowTrails" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowVehiclePhysics" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowVision" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "SkipSplash" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "Sound3d" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "SoundVolume" 0x0000000a
 		
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "Squad" ""
 		WriteRegStr HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "SquadPassword" ""
 		
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ThrustSounds" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "TipOfDay" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "TipOfDayPosition" 0x0000000c
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "TransparentMessageArea" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "TransparentNotepad" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "TripleBuffer" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "UseSystemBackBuffer" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "UseSystemVirtualBuffer" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "UseSystemZoomBuffer" 0x00000000
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "VertSync" 0x00000001
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ViewPercentToEdge" 0x000001f4
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ViewSpeed" 0x00000005
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ZoneSpecificMacros" 0x00000000

	${Next}
  
	# Give InfantryLauncher.exe admin rights.
 	WriteRegStr HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\InfantryLauncher.exeM.exe" "RUNASADMIN"
 
	# Uninstaller - See function un.onInit and section "uninstall" for configuration
	writeUninstaller "$INSTDIR\Uninstall Infantry Online.exe"
 
	# Start Menu
	createDirectory "$SMPROGRAMS\${APPNAME}"
	createShortCut "$SMPROGRAMS\${APPNAME}\InfantryLauncher.lnk" "$INSTDIR\InfantryLauncher.exe" "" "$INSTDIR\imgs\infantry.ico"
 
	# Registry information for add/remove programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "DisplayName" "${APPNAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "UninstallString" "$\"$INSTDIR\Uninstall Infantry Online.exe$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "QuietUninstallString" "$\"$INSTDIR\Uninstall Infantry Online.exe$\" /S"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "DisplayIcon" "$\"$INSTDIR\imgs\infantry.ico$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "Publisher" "$\"${COMPANYNAME}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "HelpLink" "$\"${HELPURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "URLUpdateInfo" "$\"${UPDATEURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "URLInfoAbout" "$\"${ABOUTURL}$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "DisplayVersion" "$\"${VERSIONMAJOR}.${VERSIONMINOR}.${VERSIONBUILD}$\""
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "VersionMajor" ${VERSIONMAJOR}
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "VersionMinor" ${VERSIONMINOR}
	# There is no option for modifying or repairing the install
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "NoModify" 1
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "NoRepair" 1
	# Set the INSTALLSIZE constant (!defined at the top of this script) so Add/Remove Programs can accurately report the size
	WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "EstimatedSize" ${INSTALLSIZE}
sectionEnd

# Uninstaller

function un.onInit
	SetShellVarContext all
 
	#Verify the uninstaller - last chance to back out
	MessageBox MB_OKCANCEL "Permanantly remove ${APPNAME}?" IDOK next
		Abort
	next:
	!insertmacro VerifyUserIsAdmin
functionEnd

section "uninstall"
	# Remove Start Menu launcher
	delete "$SMPROGRAMS\${APPNAME}\InfantryLauncher.lnk"
	# Try to remove the Start Menu folder
	rmDir /r "$SMPROGRAMS\${APPNAME}"
 
	# Remove files
	#delete $INSTDIR\app.exe
	#delete $INSTDIR\logo.ico
 
	# Always delete uninstaller as the last action
	delete "$INSTDIR\Uninstall Infantry Online.exe"
 
	# Try to remove the install directory
	rmDir /r $INSTDIR
 
	# TODO: Remove windows registry items?
 
	# Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}"
sectionEnd
