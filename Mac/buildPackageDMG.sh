#!/bin/sh

APP_NAME="Infantry Online"
APP_LOCATION="./_builds/app/${APP_NAME}.app"

# cd current working directory
WORKINGDIR=$(cd "$(dirname "$BASH_SOURCE")"; cd -P "$(dirname "$(readlink "$BASH_SOURCE" || echo .)")"; pwd)
cd $WORKINGDIR

APP_VERSION="1.55b"
#TODO: Get this working...
#APP_VERSION=$(defaults read "${APP_LOCATION}/Contents/Info.plist" CFBundleShortVersionString)

PKG_LOCATION="./_builds/pkg/${APP_NAME} ${APP_VERSION}.pkg"
DMG_LOCATION="./_builds/dmg/${APP_NAME//[[:blank:]]/}_${APP_VERSION}_Mac.dmg"

echo ""
echo "PACKAGING ${APP_LOCATION}, Version: ${APP_VERSION}"
echo ""
echo "***** STEP 1/3 - CLEAN UP OLD ${APP_VERSION} PKG & DMG BUILDS FIRST"
echo ""
test -f "${DMG_LOCATION}" && rm "${DMG_LOCATION}"
test -f "${PKG_LOCATION}" && rm "${PKG_LOCATION}"

echo "***** STEP 2/3 - BUILDING THE .PKG INSTALLER FILE (Will take a few minutes...)"
echo ""
if [ -d "${APP_LOCATION}" ]; then
	/usr/local/bin/packagesbuild "./_assets/Infantry Online.pkgproj"
	echo ""
	
	echo "***** STEP 3/3 - BUILDING THE DMG (Will take a few minutes...)"
	echo ""
	if [ -f "${PKG_LOCATION}" ]; then
		create-dmg \
		--volname "Install ${APP_NAME} ${APP_VERSION}" \
		--volicon "./_assets/images/floppy.icns" \
		--background "./_assets/images/background.png" \
		--window-pos 200 120 \
		--window-size 512 410 \
		--icon-size 96 \
		--text-size 12 \
		--no-internet-enable \
		--icon "${APP_NAME} ${APP_VERSION}.pkg" 385 240 \
		"${DMG_LOCATION}" \
		"./_builds/pkg/"
		echo ""
		
		if [ -f "${DMG_LOCATION}" ]; then
			echo "DMG built here:"
			echo "${DMG_LOCATION}"
			open ./_builds/dmg/
		else
			echo "ERROR: ${DMG_LOCATION} is missing"
			echo ""
		fi
	else
		echo ""
		echo "ERROR: ${PKG_LOCATION} is missing"
		echo ""
	fi
  
else
	echo ""
	echo "ERROR: ${APP_LOCATION} is missing"
	echo ""
fi
