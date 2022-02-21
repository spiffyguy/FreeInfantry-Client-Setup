
!define APPNAME "Infantry Online"
!define COMPANYNAME "Free Infantry Group"
!define DESCRIPTION "Infantry is an online-only multiplayer action game with a science fiction theme. Players can spectate or join one of multiple game types running simultaneously, and communicate through an in-game chat window."

!define VERSIONMAJOR 1
!define VERSIONMINOR 55
!define VERSIONBUILD 0

!define HELPURL "https://discord.gg/2avPSyv" # "Support Information" link
!define UPDATEURL "http://www.freeinfantry.com" # "Product Updates" link
!define ABOUTURL "http://www.freeinfantry.com" # "Publisher" link

#TODO: need to confirm this...
!define INSTALLSIZE 512000

RequestExecutionLevel admin ;Require admin rights on NT6+ (When UAC is turned on)

InstallDir "$PROGRAMFILES\${APPNAME}"

#LicenseData "license.rtf"

Name "${APPNAME} - ${COMPANYNAME}"
Icon "_builds\launcher\imgs\infantry.ico"
outFile "_builds\installer\Install-Infantry-Online.exe"

!include LogicLib.nsh

#page license
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

	File /r "_builds\launcher\*"
	#file "InfantryLauncher.exe"
	#file "Newtonsoft.Json.dll"
	#file "default.ini"
	#file /r "imgs"
 
	# TODO: need to add all the required registry stuff for the game.
 
	# Give InfantryLauncher.exe admin rights.
 	WriteRegStr HKEY_LOCAL_MACHINE "SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers" "$INSTDIR\InfantryLauncher.exeM.exe" "RUNASADMIN"
 
	# Uninstaller - See function un.onInit and section "uninstall" for configuration
	writeUninstaller "$INSTDIR\Uninstall Infantry Online.exe"
 
	# Start Menu
	createDirectory "$SMPROGRAMS\${APPNAME}"
	createShortCut "$SMPROGRAMS\${APPNAME}\InfantryLauncher.lnk" "$INSTDIR\InfantryLauncher.exe" "" "$INSTDIR\imgs\infantry.ico"
 
	# Registry information for add/remove programs
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}" "DisplayName" "${APPNAME} - ${DESCRIPTION}"
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
	delete $INSTDIR\Uninstall Infantry Online.exe
 
	# Try to remove the install directory
	rmDir /r $INSTDIR
 
	# Remove uninstaller information from the registry
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${COMPANYNAME} - ${APPNAME}"
sectionEnd
