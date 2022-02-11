# Infantry Online Client Setup Files

Source Setup/Installer files for the Infantry Online game. (http://freeinfantry.com)

## WINDOWS

### [Windows] Prerequisites
 - Visual Studio 2019 Community Edition
 - TODO: more...

### [Windows] Steps

#### [Windows] Building the Installer
 - TODO

## macOS

### [macOS] Prerequisites

 - Minimum macOS 10.13 High Sierra
 - WineSkin Wrapper (https://github.com/Gcenx/WineskinServer)
 - Mac "Packages" app (http://s.sudre.free.fr/Software/Packages/about.html)
 - `brew install create-dmg` (https://github.com/create-dmg/create-dmg)
 - cnc-ddraw (https://github.com/CnCNet/cnc-ddraw)

### [macOS] Steps

#### [macOS] Wrapping the windows Infantry Online Client into a Mac .app with WineSkin
 1. TODO

#### [macOS] Building the Installer
 1. Place the built WineSkin wrapped client app here: "./Mac/_build/app/Infantry Online.app"
 2. Run the "./Mac/buildPackageDMG.sh" in the terminal to build a .pkg installer file and a distributable dmg file.

## Thanks

 - Gcenx for his updates on WineSkin (originally created by doh123)
 - Realm AKA Col. Kitty Hawk for rnd/testing
 - The whole FreeInfantry team.
 - Many more people
