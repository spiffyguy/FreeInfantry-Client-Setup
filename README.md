# Infantry Online Client Setup/Installer Files

**Download the latest built, ready to play, Infantry Online client at: [http://freeinfantry.com](http://freeinfantry.com)**

Setup/Installer source files for the Infantry Online game:

## Windows
**Windows 7 SP1 or later**

<details>
  <summary>(TODO) Building the "Advanced Installer"</summary>

>
> **Download/Install First**
> 
> - Visual Studio 2019 Community Edition ([https://visualstudio.microsoft.com/vs/older-downloads/](https://visualstudio.microsoft.com/vs/older-downloads/))
> 

1. Get the official Infantry Online Launcher .exe file either from:

	- Compiling yourself from the Launcher repo or
	- Downloading the windows launcher exe

2. (TODO) More things...

</details>

<details>
  <summary>(TODO) Installing the Game (with Screenshots)</summary>

- TODO
</details>


## macOS
**macOS 10.13 (High Sierra) or later**

<details>
  <summary>(TODO) How to wrap the Windows .exe into a Mac .app with WineSkin</summary>

>
> **Download/Install First**
> 
> - WineSkin Wrapper ([https://github.com/Gcenx/WineskinServer](https://github.com/Gcenx/WineskinServer))
> - cnc-ddraw ([https://github.com/CnCNet/cnc-ddraw](https://github.com/CnCNet/cnc-ddraw))
> 

- TODO
</details>

<details>
  <summary>Building the PKG Installer into a DMG</summary>

>
> **Download/Install First**
> 
> - Mac "Packages" app ([http://s.sudre.free.fr/Software/Packages/about.html](http://s.sudre.free.fr/Software/Packages/about.html))
> - `brew install create-dmg` ([https://github.com/create-dmg/create-dmg](https://github.com/create-dmg/create-dmg))
> 

 1. Place the built WineSkin wrapped client app here: "./Mac/_build/app/Infantry Online.app"
 2. Run the "./Mac/buildPackageDMG.sh" in the terminal to build a .pkg installer file and a distributable dmg file.
</details>

<details>
  <summary>Installing the Game (with Screenshots)</summary>

 - 1. Open the **DMG Volume Icon**

![DMG Volume](Mac/_screenshots/DMGVolume.png)

 - 2. Open the **.pkg** file by Control-Click and choosing "Open" in the contextual menu

![DMG Installer Window](Mac/_screenshots/DMGInstallerWindow.png)
</details>

## GNU/Linux
**Any Distro that WINE supports**

<details>
  <summary>(TODO) Lutris Script</summary>

- TODO
</details>

<details>
  <summary>(TODO) PlayOnLinux Script</summary>

- TODO
</details>

<details>
  <summary>(TODO) Building SnapCraft Script</summary>

- TODO
</details>

<details>
  <summary>(TODO) Manual Install with PlayOnLinux (with Screenshots)</summary>

- TODO
</details>

## Thanks to all Contributors

#### FreeInfantry
 - Realm (AKA Col. Kitty Hawk) for RnD/testing
 - Jovan for helping with the repo & website
 - SocketMix for PlayOnLinux manual install guide and testing
 - The whole FreeInfantry team and players

#### CNC-DDraw
 - FunkyFr3sh for his work on cnc-ddraw to support this game for modern windows and WINE

#### Wineskin
 - Gcenx for his updates on WineSkin (originally created by doh123)

#### Many more people
