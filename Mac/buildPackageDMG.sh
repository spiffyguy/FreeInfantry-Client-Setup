#!/bin/sh

APP_NAME="Infantry Online"
APP_LOCATION="./_builds/app/${APP_NAME}.app"

SKIP_PKG=false
SKIP_DMG=false

# cd current working directory
WORKINGDIR=$(cd "$(dirname "$BASH_SOURCE")"; cd -P "$(dirname "$(readlink "$BASH_SOURCE" || echo .)")"; pwd)
cd $WORKINGDIR

if [ -d "${APP_LOCATION}" ]; then
	APP_VERSION=$(plutil -extract CFBundleShortVersionString raw -o - "${APP_LOCATION}/Contents/Info.plist")
	#OVERRIDE PACKAGING VISIBLE VERSION?
	#APP_VERSION="1.55b"
	
	APP_NAMEVERSION_NOSPACES="${APP_NAME//[[:blank:]]/}_${APP_VERSION//[[:blank:]]/}"
	
	PKGPROJ_LOCATION="./_assets/${APP_NAME}.pkgproj"
	PKG_LOCATION="./_builds/pkg/${APP_NAME} ${APP_VERSION}.pkg"
	DMG_LOCATION="./_builds/dmg/${APP_NAMEVERSION_NOSPACES}_Mac.dmg"
	
	echo ""
	echo "*********"
	echo "PACKAGING ${APP_LOCATION}, Version: ${APP_VERSION}"
	echo "*********"
	echo ""
	echo "***** STEP 1/3 - CLEAN UP OLD ${APP_VERSION} PKG & DMG BUILDS FIRST"
	echo ""
	if [ "$SKIP_PKG" = false ]; then
		test -f "${PKG_LOCATION}" && rm "${PKG_LOCATION}"
	fi
	if [ "$SKIP_DMG" = false ]; then
		test -f "${DMG_LOCATION}" && rm "${DMG_LOCATION}"
	else
		if [ "$SKIP_PKG" = false ]; then
			# if a new PKG is being created, remove the same named DMG version that will be obsolete...
			test -f "${DMG_LOCATION}" && rm "${DMG_LOCATION}"
		fi
	fi
	
	echo "***** STEP 2/3 - BUILDING THE .PKG INSTALLER FILE (Will take a few minutes...)"
	echo ""
	
	if [ "$SKIP_PKG" = false ]; then
		# UPDATE .pkg NAMES
		/usr/bin/plutil -replace PROJECT.PROJECT_SETTINGS.NAME -string "${APP_NAME} ${APP_VERSION}" "${PKGPROJ_LOCATION}"
		/usr/bin/plutil -replace PROJECT.PACKAGE_SETTINGS.VERSION -string "${APP_VERSION}" "${PKGPROJ_LOCATION}"
		/usr/bin/plutil -replace PROJECT.PACKAGE_SETTINGS.IDENTIFIER -string "com.${USER}.${APP_NAMEVERSION_NOSPACES}" "${PKGPROJ_LOCATION}"
		
		# Notice extra dot before APP_LOCATION to mean back a directory...
		/usr/bin/plutil -replace PROJECT.PACKAGE_FILES.HIERARCHY.CHILDREN.0.CHILDREN.0.PATH -string ".${APP_LOCATION}" "${PKGPROJ_LOCATION}"
		
		/usr/bin/sed -i '' -e 's/\(file "\)\(.*\)\("\)/\1'"$(printf '%s\n' "/Applications/${APP_NAME}.app" | sed -e 's/[\/&]/\\&/g')"'\"/g' ./_assets/scripts/reveal.sh
	
		/usr/local/bin/packagesbuild "${PKGPROJ_LOCATION}"
	else
		echo "SKIPPING PKG CREATION"
	fi
	echo ""
		
	echo "***** STEP 3/3 - BUILDING THE DMG (Will take a few minutes...)"
	echo ""
	if [ -f "${PKG_LOCATION}" ]; then
		if [ "$SKIP_DMG" = false ]; then
			create-dmg \
			--volname "Install ${APP_NAME} ${APP_VERSION}" \
			--volicon "./_assets/images/floppy.icns" \
			--background "./_assets/images/background.png" \
			--window-pos 200 120 \
			--window-size 512 410 \
			--icon-size 96 \
			--text-size 12 \
			--no-internet-enable \
			--icon "${APP_NAME} ${APP_VERSION}.pkg" 385 230 \
			"${DMG_LOCATION}" \
			"./_builds/pkg/"
			
			if [ -f "${DMG_LOCATION}" ]; then
				echo "DMG built here:"
				echo "${DMG_LOCATION}"
				open ./_builds/dmg/
			else
				echo "ERROR: ${DMG_LOCATION} is missing"
				echo ""
			fi
			
		else
			echo "SKIPPING DMG CREATION"
		fi
		echo ""
		
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
