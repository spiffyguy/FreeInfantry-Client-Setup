# Author : Spiff
# Date : (2022-02-21 09-00)
# Last revision : (2024-02-11 08-38)

!define /date MyTIMESTAMP "%Y-%m-%d-%H-%M-%S"

# TODO: this is too slow for compressing and installing...
#SetCompressor /SOLID lzma
#SetCompressorDictSize 64
#SetDatablockOptimize ON

!define USENEWASSETSFOLDER true
Var ASSETDIR

!define APPNAME "FreeInfantry"
!define COMPANYNAME "Free Infantry Group"
!define DESCRIPTION "Infantry is an online-only multiplayer action game with a science fiction theme. Players can spectate or join one of multiple game types running simultaneously, and communicate through an in-game chat window."

!define VERSIONMAJOR 1
!define VERSIONMINOR 55
!define VERSIONBUILD 0

!define HELPURL "https://discord.gg/2avPSyv" # "Support Information" link
!define UPDATEURL "http://www.freeinfantry.com/download/" # "Product Updates" link
!define ABOUTURL "http://www.freeinfantry.com" # "Publisher" link

#TODO: need to confirm this size...
!define INSTALLSIZE 5940

!define MUI_WELCOMEFINISHPAGE_BITMAP "_assets\images\nsis-welcomefinish-164x314.bmp"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "_assets\images\nsis-header-150x57.bmp"
!define MUI_ABORTWARNING
!define MUI_BGCOLOR 000000
!define MUI_TEXTCOLOR FFFFFF
#!define MUI_LICENSEPAGE_BGCOLOR 000000
#!define MUI_DIRECTORYPAGE_BGCOLOR 000000
#!define MUI_STARTMENUPAGE_BGCOLOR 000000
#!define MUI_INSTFILESPAGE_COLORS 123456
#!define MUI_INSTFILESPAGE_PROGRESSBAR colored

!include "MUI2.nsh"
!include FileFunc.nsh
!include LogicLib.nsh
Unicode True

RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)
!addplugindir "_assets\nsis-plugins"

InstallDir "$PROGRAMFILES\${APPNAME}"
# Get installation folder from registry if available
InstallDirRegKey HKCU "Software\HarmlessGames\Infantry\Launcher" "Path"

Name "${APPNAME}"
!if ${INSTALLINITIALASSETS} == true
	!if ${NOLAUNCHERUPDATES} == true
		OutFile "_builds\installer\Install-FreeInfantry-NoAutoUpdate-${MyTIMESTAMP}.exe"
	!else
		OutFile "_builds\installer\Install-FreeInfantry-${MyTIMESTAMP}.exe"
	!endif
!else
	OutFile "_builds\installer\Install-FreeInfantry-Lite-${MyTIMESTAMP}.exe"
!endif

!define MUI_ICON "_assets\images\floppy.ico" 
!define MUI_UNICON "_assets\images\floppy.ico"

Var defaultCncddrawRenderer
Var screenResolutionWidth
Var screenResolutionHeight

# PAGES

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "_assets/License.rtf"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
Var /GLOBAL StartMenuFolder
!insertmacro MUI_PAGE_STARTMENU MyStartMenuPage $StartMenuFolder
!insertmacro MUI_PAGE_INSTFILES

# TODO: need to figure out how to make this work AND how to fix the font color...
!define MUI_FINISHPAGE_RUN
!define MUI_FINISHPAGE_RUN_TEXT "Play FreeInfantry Now"
!define MUI_FINISHPAGE_RUN_FUNCTION "RunFreeInfantry"
!define MUI_FINISHPAGE_LINK "https://freeinfantry.com"
!define MUI_FINISHPAGE_LINK_LOCATION "https://freeinfantry.com"
!define MUI_FINISHPAGE_LINK_COLOR FFFFFF
!define MUI_PAGE_CUSTOMFUNCTION_SHOW finish_show_function ; fix issue with run checkbox text same color as BG
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

# LANGUAGE

!insertmacro MUI_LANGUAGE "English"

# FUNCTIONS

Function finish_show_function
	SetCtlColors $mui.FinishPage.Run 0xFFFFFF 0x666666 ; fix issue with run checkbox text same color as BG
Functionend

Function RunFreeInfantry
  ExecShell "" "$ASSETDIR\InfantryLauncher.exe"
FunctionEnd

# MACROS

!macro VerifyUserIsAdmin
UserInfo::GetAccountType
pop $0
${If} $0 != "admin" ;Require admin rights on NT4+
        MessageBox mb_iconstop "Administrator rights required!"
        SetErrorLevel 740 ;ERROR_ELEVATION_REQUIRED
        Quit
${EndIf}
!macroend

!macro MaybeWriteRegStr sub_key key_name key_value key_override
	ClearErrors
	ReadRegStr $0 HKCU "${sub_key}" "${key_name}"
	${If} ${Errors}
		WriteRegStr HKCU "${sub_key}" "${key_name}" "${key_value}"
	${Else}
		${IF} $0 == ""
			${IF} ${key_override} == "1"
			WriteRegStr HKCU "${sub_key}" "${key_name}" "${key_value}"
			${ENDIF}
	    ${ELSE}
			${IF} ${key_override} == "1"
			WriteRegStr HKCU "${sub_key}" "${key_name}" "${key_value}"
			${ENDIF}
	    ${ENDIF}
	${EndIf}
!macroend

!macro MaybeWriteRegDWORD sub_key key_name key_value key_override
	ClearErrors
	ReadRegDWORD $0 HKCU "${sub_key}" "${key_name}"
	${If} ${Errors}
		WriteRegDWORD HKCU "${sub_key}" "${key_name}" "${key_value}"
	${Else}
		${IF} $0 == ""
			${IF} ${key_override} == "1"
			WriteRegDWORD HKCU "${sub_key}" "${key_name}" "${key_value}"
			${ENDIF}
	    ${ELSE}
			${IF} ${key_override} == "1"
			WriteRegDWORD HKCU "${sub_key}" "${key_name}" "${key_value}"
			${ENDIF}
	    ${ENDIF}
	${EndIf}
!macroend

!macro WriteInfantryRegistry key_override

	#############
	#	Registry - MISC
	#############
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "Accepted" 0x00000000 ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "BL" 0x00000000 ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "BP" 0x00000000 ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "GlobalNewsCrc" 0x00000000 ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "HighPriority" 0x00000000 ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "LastProfile" 0x00000000 ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "LastVersionExecuted" 0x0000009b ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "ReleaseNotesCrc" 0x00000000 ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "SC" 0x00000000 ${key_override}
	!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Misc" "ST" 0x00000000 ${key_override}
	 
	#############
	#	Registry - PROFILES
	#############
 
	# (This loops 6 times.... ie: Profile5,Profile4,Profile3,Profile2,Profile1,Profile0)
	${ForEach} $1 5 0 - 1
		
		#############
		#	Registry - Profile Login
		#############
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Login" "Name" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Login" "ParentName" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Login" "ServerName" "" ${key_override}
		
		#############
		#	Registry - Profile Chat
		#############
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel0" "newbies" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel1" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel2" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel3" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel4" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel5" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel6" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel7" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Chat" "Channel8" "" ${key_override}
		
		#############
		#	Registry - Profile HiddenOptions
		#############
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\HiddenOptions" "ZoomMax" 0x000003e8 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\HiddenOptions" "ZoomTime" 0x00000064 ${key_override}

		#############
		#	Registry - Profile Keyboard
		#############
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "0" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "1" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "2" 0x015c0000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "3" 0x014c0000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "4" 0x00c40000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "5" 0x00c80000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "6" 0x01040000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "7" 0x01100000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "8" 0x0040ae00 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "9" 0x0040a600 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "10" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "11" 0x00040000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "12" 0x00100000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "13" 0x00080000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "14" 0x01440000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "15" 0x01140000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "16" 0x00440000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "17" 0x01480000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "18" 0x01180000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "19" 0x00800000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "20" 0x011c0000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "21" 0x01200000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "22" 0x00900000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "23" 0x01200000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "24" 0x01500000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "25" 0x01640000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "26" 0x01540000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "27" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "28" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "29" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "30" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "31" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "32" 0x00480000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "33" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "34" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "35" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "36" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "37" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "38" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "39" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "40" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "41" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "42" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "43" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "44" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "45" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "46" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "47" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "48" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "49" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "50" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "51" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "52" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "53" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "54" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "55" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "56" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "57" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "58" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "59" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "60" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "61" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "62" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "63" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "64" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "65" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "66" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "67" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "68" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "69" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "AxisDeadzone" 0x00001f40 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "AxisRotate" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "AxisStrafe" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "AxisThrust" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "EnterForMessages" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "LeftRight" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "MouseLeft" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "MouseMiddle" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "MouseRight" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "MovementMode" 0x00000003 ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Keyboard" "ReservedFirstLetters" "~ `+-" ${key_override}

		#############
		#	Registry - Profile Message
		#############
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "Alarm" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "Entering" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterChat" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterKill" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterPopup" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterPrivate" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterPublic" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterPublicMacro" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterSquad" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterSystem" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FilterTeam" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "FixCase" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "Height" 0x00000054 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "Leaving" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Message" "NameWidth" 0x00000054 ${key_override}

		#############
		#	Registry - Profile Options
		#############
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "AdjustSoundDelay" 0x00000005 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "AlternateClock" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "AutoLogMessages" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "AvoidPageFlipping" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "BannerCacheSize" 0x000001f4 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "BlockObscene2" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ChatChannelEntering" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "CoordinateMode" 0x00000003 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "DeathMessageMode" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "DetailLevel" 0x00000002 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "DisableJoystick" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "DisplayLosAlpha" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "DisplayLosMode" 0x00000002 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "DisplayMapGrid" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "EnergyPercent" 0x00000258 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "EnvironmentAudio" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "FakeAlpha" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "HideSmartTrans" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "IsAllowSpectators" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "MainRectBottom" 0x000004af ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "MainRectLeft" 0x00000026 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "MainRectRight" 0x0000041c ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "MainRectTop" 0x00000278 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "NotepadLastWidth" 0x000000a0 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "NotepadWidth" 0x000000a0 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "PlayerListHeightPercent" 0x00000db2 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "PlayerSortMode" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "RadarGammaPercent" 0x000003e8 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "RenderBackground" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "RenderParallax" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "RenderStarfield" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "RollMode" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "RotateRampTime" 0x00000019 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "RotationCount" 0x00000040 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "RotationSounds" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Options" "SDirectoryAddress" "infdir1.aaerox.com" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Options" "SDirectoryAddressBackup" "infdir2.aaerox.com" ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowAimingTick" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowBallTrails" 0x000001f4 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowBanners" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowClock" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowDifficultyLevel" 0x00000064 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowEnemyThrust" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowEnergyBar" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowFrameRate" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowHealthGuage" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowKeystrokes" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowLogo" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowMessageType" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowPhysics" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowSelfName" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowTerrain" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowTrails" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowVehiclePhysics" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ShowVision" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "SkipSplash" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "Sound3d" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "SoundVolume" 0x0000000a ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Options" "Squad" "" ${key_override}
 		!insertmacro MaybeWriteRegStr "Software\HarmlessGames\Infantry\Profile$1\Options" "SquadPassword" "" ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ThrustSounds" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "TipOfDay" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "TipOfDayPosition" 0x0000000c ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "TransparentMessageArea" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "TransparentNotepad" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "TripleBuffer" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "UseSystemBackBuffer" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "UseSystemVirtualBuffer" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "UseSystemZoomBuffer" 0x00000000 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "VertSync" 0x00000001 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ViewPercentToEdge" 0x000001f4 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ViewSpeed" 0x00000005 ${key_override}
 		!insertmacro MaybeWriteRegDWORD "Software\HarmlessGames\Infantry\Profile$1\Options" "ZoneSpecificMacros" 0x00000000 ${key_override}

 		# Set the resolution of Infantry to the current monitor resolution.
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ResolutionX" $screenResolutionWidth
 		WriteRegDWORD HKCU "Software\HarmlessGames\Infantry\Profile$1\Options" "ResolutionY" $screenResolutionHeight

	${Next}

!macroend

!macro editandinstallcncddraw renderername
	
	SetOutPath "$ASSETDIR"
	
	#############
	#	Files - CNC-DDraw
	#############
	File "_builds\cnc-ddraw\ddraw.dll"
	File "_builds\cnc-ddraw\ddraw.ini"
	File "_builds\cnc-ddraw\cnc-ddraw config.exe"
	File /r "_builds\cnc-ddraw\Shaders"
	
	# Set the FreeInfantry Specific Hacks for cnc-ddraw
	WriteINIStr $ASSETDIR\ddraw.ini ddraw infantryhack true
	WriteINIStr $ASSETDIR\ddraw.ini ddraw renderer "${renderername}"
	
	# Set DDraw override for WINE in the registry. (Registry Key ignored on actual Windows)
	WriteRegStr HKCU "Software\Wine\DllOverrides" "ddraw" "native,builtin"

!macroend

Section "${APPNAME}" Seclauncher

	CreateDirectory "$INSTDIR"
	SetOutPath "$ASSETDIR"

	#############
	#	Main Infantry Launcher
	#############
	!if ${NOLAUNCHERUPDATES} == true
		File "_builds\launcher\InfantryLauncherNoAutoUpdate\InfantryLauncher.exe"
	!else
		File "_builds\launcher\InfantryLauncher.exe"
	!endif
	
	!define MUI_FINISHPAGE_RUN "$ASSETDIR\InfantryLauncher.exe"
	
	File "_builds\launcher\Newtonsoft.Json.dll"
	File "_builds\launcher\default.ini"
	File /r /x .DS_Store "_builds\launcher\imgs"
 
	!if ${INSTALLINITIALASSETS} == true
		File /r /x .DS_Store "_builds\game-initial-assets\*.*"
	!endif
 
	#File /r /x .DS_Store "_builds\game-editors\Infantry Editors\*.*"
	#File /r /x .DS_Store "_builds\game-editors\Misc"

	${IF} ${USENEWASSETSFOLDER} == true
		CreateDirectory "$ASSETDIR"
		AccessControl::SetOnFile "$ASSETDIR" "Everyone" "FullAccess"
		IfFileExists $INSTDIR\Assets FoundAssetsSubFolder
	    	CreateShortcut "$INSTDIR\Assets.lnk" "$ASSETDIR"
			FoundAssetsSubFolder:
		CreateShortcut "$INSTDIR\${APPNAME}.lnk" "$ASSETDIR\InfantryLauncher.exe"
	 	WriteRegStr HKCU "Software\HarmlessGames\Infantry\Launcher" "AssetsPath" "$ASSETDIR"
	${ENDIF}
 
 	# Start Menu
	${IFNOT} $StartMenuFolder == ""
	 	StrCpy $0 $StartMenuFolder 1
		${IFNOT} $0 == ">"
			CreateDirectory "$SMPROGRAMS\$StartMenuFolder"
			CreateShortCut "$SMPROGRAMS\$StartMenuFolder\${APPNAME}.lnk" "$ASSETDIR\InfantryLauncher.exe" "" "$ASSETDIR\imgs\infantry.ico"
		${ENDIF}
	${ENDIF}
	
	#############
	#	Registry - LAUNCHER
	#############
 	WriteRegStr HKCU "Software\HarmlessGames\Infantry\Launcher" "Path" "$ASSETDIR"
	#${IF} ${USENEWASSETSFOLDER} == true
	# 	WriteRegStr HKCU "Software\HarmlessGames\Infantry\Launcher" "Version" "1.0" # New Launcher...
	#${Else}
	 	WriteRegStr HKCU "Software\HarmlessGames\Infantry\Launcher" "Version" "2.2.0.0" # TODO: get from default.ini file
	#${ENDIF}
	
 	#############
	#	Uninstaller
	#############

	# Uninstaller - See function un.onInit and section "uninstall" for configuration
	writeUninstaller "$INSTDIR\Uninstall FreeInfantry.exe"
 	
	# Registry information for add/remove programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "DisplayName" "${APPNAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "UninstallString" "$\"$INSTDIR\Uninstall FreeInfantry.exe$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "QuietUninstallString" "$\"$INSTDIR\Uninstall FreeInfantry.exe$\" /S"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "InstallLocation" "$\"$INSTDIR$\""
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "DisplayIcon" "$\"$ASSETDIR\imgs\infantry.ico$\""
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
	
	!insertmacro WriteInfantryRegistry "0"
	
SectionEnd

# "auto" right now means direct3d9/opengl, gdi fallback, so using auto instead of only "direct3d9"
Section "cnc-ddraw, d3d9" Seccncddraw-auto
	!insertmacro editandinstallcncddraw "auto"
SectionEnd

Section /o "cnc-ddraw, opengl" Seccncddraw-opengl
	!insertmacro editandinstallcncddraw "opengl"
SectionEnd

SectionGroup "Reset/Clear"
	Section /o "Registry Settings" Secfixregistry
	
		!insertmacro WriteInfantryRegistry "1"
			
	sectionEnd
	
	Section /o "Saved Login" Secclearsavedlogin
		
		IfFileExists "$ASSETDIR\settings.ini" file_found file_not_found
		file_found:
			WriteINIStr $ASSETDIR\settings.ini Credentials Username ""
			WriteINIStr $ASSETDIR\settings.ini Credentials Password ""

			goto end_of_test
		file_not_found:
			# Nothing to do, already cleared
		end_of_test:
			# Done checking for settings.ini
			
	sectionEnd
SectionGroupEnd

Function .onInit
	setShellVarContext all
		
	StrCpy $INSTDIR "$PROGRAMFILES\${APPNAME}"
	# StrCpy $ASSETDIR "$INSTDIR\Assets"

	!insertmacro VerifyUserIsAdmin
	
	System::Call 'user32::GetSystemMetrics(i 0) i .r0'
	System::Call 'user32::GetSystemMetrics(i 1) i .r1'
	StrCpy $screenResolutionWidth "$0"
	StrCpy $screenResolutionHeight "$1"
	
	# Get a /ddraw override from the command line
	StrCpy $defaultCncddrawRenderer "auto"
	${GetParameters} $0
	ClearErrors
	${GetOptions} $0 "/ddraw=" $1
	${IfNot} ${Errors}
		StrCpy $defaultCncddrawRenderer $1
	${EndIf}
	
	# Only allow 1 ddraw selection at a time....
	Push $0
	
	StrCpy $R9 ${Seccncddraw-auto} # Gotta remember which section we are at now...
	SectionGetFlags ${Seccncddraw-auto} $0
	IntOp $0 $0 | ${SF_SELECTED}
	SectionSetFlags ${Seccncddraw-auto} $0
	
	SectionGetFlags ${Seccncddraw-opengl} $0
	IntOp $0 $0 & ${SECTION_OFF}
	SectionSetFlags ${Seccncddraw-opengl} $0
	
	# Look at the ddraw override command line....
	# TODO: allow gdi as a choice as well
	${IF} $defaultCncddrawRenderer == "opengl"
		StrCpy $R9 ${Seccncddraw-opengl}
		SectionGetFlags ${Seccncddraw-opengl} $0
		IntOp $0 $0 | ${SF_SELECTED}
		SectionSetFlags ${Seccncddraw-opengl} $0
		SectionGetFlags ${Seccncddraw-auto} $0
		IntOp $0 $0 & ${SECTION_OFF}
		SectionSetFlags ${Seccncddraw-auto} $0
	${ENDIF}
	
	Pop $0
	
FunctionEnd

Function .onVerifyInstDir
	StrCmp $INSTDIR "$PROGRAMFILES\${APPNAME}" 0 +3
		StrCpy $ASSETDIR "$LOCALAPPDATA\${APPNAME}"
		Goto PathIsGood
		StrCpy $ASSETDIR "$INSTDIR\Assets"
	PathIsGood:
FunctionEnd

Function .onSelChange

	# Only allow 1 ddraw selection at a time....
	Push $0
	
	StrCmp $R9 ${Seccncddraw-auto} check_Seccncddraw-auto
	
	SectionGetFlags ${Seccncddraw-auto} $0
	IntOp $0 $0 & ${SF_SELECTED}
	IntCmp $0 ${SF_SELECTED} 0 done done
		StrCpy $R9 ${Seccncddraw-auto}
		SectionGetFlags ${Seccncddraw-opengl} $0
		IntOp $0 $0 & ${SECTION_OFF}
		SectionSetFlags ${Seccncddraw-opengl} $0
	
	Goto done
	
	check_Seccncddraw-auto:
		
		SectionGetFlags ${Seccncddraw-opengl} $0
		IntOp $0 $0 & ${SF_SELECTED}
		IntCmp $0 ${SF_SELECTED} 0 done done
			StrCpy $R9 ${Seccncddraw-opengl}
			SectionGetFlags ${Seccncddraw-auto} $0
			IntOp $0 $0 & ${SECTION_OFF}
			SectionSetFlags ${Seccncddraw-auto} $0
		
	done:
	
	Pop $0
FunctionEnd

# Descriptions

  # Language strings
  LangString DESC_Seclauncher ${LANG_ENGLISH} "Official FreeInfantry Launcher.$\r$\n$\r$\nBrought to you by ${COMPANYNAME}."
  LangString DESC_Seccncddraw-auto ${LANG_ENGLISH} "cnc-ddraw Library, Fixes fullscreen and improves FPS.$\r$\n$\r$\nDirect3d9 Renderer. (best for Windows)"
  LangString DESC_Seccncddraw-opengl ${LANG_ENGLISH} "cnc-ddraw Library, Fixes fullscreen and improves FPS.$\r$\n$\r$\nOpenGL Renderer. (best for Mac/Linux)"
  LangString DESC_Secfixregistry ${LANG_ENGLISH} "Reset FreeInfantry Registry settings to their default values.$\r$\n$\r$\nThis would reset keyboard/mouse settings and aliases.$\r$\n$\r$\nCANNOT UNDO."
  LangString DESC_Secclearsavedlogin ${LANG_ENGLISH} "Clear saved login credentials.$\r$\n$\r$\nThis would clear the saved username/password in the launcher.$\r$\n$\r$\nCANNOT UNDO."

  # Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
  !insertmacro MUI_DESCRIPTION_TEXT ${Seclauncher} $(DESC_Seclauncher)
  !insertmacro MUI_DESCRIPTION_TEXT ${Seccncddraw-auto} $(DESC_Seccncddraw-auto)
  !insertmacro MUI_DESCRIPTION_TEXT ${Seccncddraw-opengl} $(DESC_Seccncddraw-opengl)
  !insertmacro MUI_DESCRIPTION_TEXT ${Secfixregistry} $(DESC_Secfixregistry)
  !insertmacro MUI_DESCRIPTION_TEXT ${Secclearsavedlogin} $(DESC_Secclearsavedlogin)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

# Uninstaller

function un.onInit
	SetShellVarContext all
 
	#Verify the uninstaller - last chance to back out
	MessageBox MB_OKCANCEL "Permanantly remove ${APPNAME}?" IDOK next
		Abort
	next:
	!insertmacro VerifyUserIsAdmin
functionEnd

Section "Uninstall"
	# Try to remove the Start Menu folder
	!insertmacro MUI_STARTMENU_GETFOLDER MyStartMenuPage $StartMenuFolder
	${IFNOT} $StartMenuFolder == ""
	 	StrCpy $0 $StartMenuFolder 1
		${IFNOT} $0 == ">"
			Delete "$SMPROGRAMS\$StartMenuFolder\${APPNAME}.lnk"
			RMDir "$SMPROGRAMS\$StartMenuFolder"
		${ENDIF}
	${ENDIF}
 
	# Remove files
	#delete $INSTDIR\app.exe
	#delete $INSTDIR\logo.ico
 
 	${IF} ${USENEWASSETSFOLDER} == true
		# Try to remove the assets directory
		rmDir /r $ASSETDIR
	${ENDIF}
 
	# Always delete uninstaller as the last action
	delete "$INSTDIR\Uninstall FreeInfantry.exe"
 
	# Try to remove the install directory
	rmDir /r $INSTDIR
	
	# TODO: Remove windows registry items?
 
	# Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}"
sectionEnd

# SIGNING - TODO
#!finalize '.\_assets\signing\sign.bat "%1" "${APPNAME} Installer" ${ABOUTURL}'
#!uninstfinalize '.\_assets\signing\sign.bat "%1" "${APPNAME} Uninstaller" ${ABOUTURL}'
