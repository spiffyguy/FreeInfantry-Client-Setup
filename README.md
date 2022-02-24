# Infantry Online Client Setup/Installer Files

**Download the latest built, ready to play, Infantry Online client at: [http://freeinfantry.com](http://freeinfantry.com)**

Navigate the sections below for instructions on how to compile or run the Installer source files for the Infantry Online game on each platform.

## Windows
**Windows XP or later (Yes, including Windows 11)**

<details>
  <summary>Building the "NSIS" Script Installer</summary>

>
> **Prerequisites**
> 
> 1. *[Download/Install]* NSIS, Nullsoft Scriptable Install System ([https://nsis.sourceforge.io](https://nsis.sourceforge.io))
> 2. *[Download]* Built InfantryLauncher.exe & it's required files ([https://github.com/InfantryOnline/Infantry-Online-Server](https://github.com/InfantryOnline/Infantry-Online-Server))
> 3. *[Download]* cnc-ddraw ([https://github.com/CnCNet/cnc-ddraw](https://github.com/CnCNet/cnc-ddraw))
> 
>
> **Step By Step**
>
> 1. Clone/Download this Github Repo
> 
> 2. Move the Infantry Launcher files (InfantryLauncher.exe, default.ini, Newtonsoft.Json.dll & imgs folder) inside here: "./Windows/_builds/launcher/"
>
> 3. Move the 4 cnc-ddraw files (ddraw.dll, ddraw.ini, cnc-ddraw config.exe & Shaders folder) inside here: "./Windows/_builds/cnc-ddraw/"
>
> 4. Open the NSIS Application
>
> 5. Click "Compile NSI Scripts"
>
> 6. Choose "File" -> "Load Script..."
> 
> 7. Navigate to the "./Windows/nsis-Infantry-Online.nsi" script and choose "Open"
>
> 8. It will automatically compile and (if no errors) will build the distributable installer .exe here: "./Windows/_builds/installer/"
>
</details>

<!--
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
-->

<details>
  <summary>Installing the Game (with Screenshots)</summary>

>![Welcome Screen](Windows/_screenshots/nsis-welcome-screen.png)
>
>![License Screen](Windows/_screenshots/nsis-license-screen.png)
>
>![Components Screen](Windows/_screenshots/nsis-components-screen.png)
>
>![Finish Screen](Windows/_screenshots/nsis-finish-screen.png)
>
</details>


## macOS
**macOS 10.13 (High Sierra) or later**

<details>
  <summary>(TODO) How to wrap the Windows .exe into a Mac .app with WineSkin</summary>

>
> **Prerequisites**
> 
> 1. *[Download/Install]* Wineskin Wrapper ([https://github.com/Gcenx/WineskinServer](https://github.com/Gcenx/WineskinServer))
> 2. *[Download]* cnc-ddraw ([https://github.com/CnCNet/cnc-ddraw](https://github.com/CnCNet/cnc-ddraw))
> 
>
> **Step By Step**
>
> - TODO
>
</details>

<details>
  <summary>Building the PKG Installer into a DMG</summary>

>
> **Prerequisites**
> 
> 1. *[Download/Install]* Mac "Packages" app ([http://s.sudre.free.fr/Software/Packages/about.html](http://s.sudre.free.fr/Software/Packages/about.html))
> 2. *[Download/Install]* Homebrew, The Missing Package Manager for macOS ([https://brew.sh](https://brew.sh))
> 3. `brew install create-dmg` ([https://github.com/create-dmg/create-dmg](https://github.com/create-dmg/create-dmg))
> 
> 
> **Step By Step**
>
> 1. Clone/Download this Github Repo
>
> 2. Place the built Wineskin wrapped Infantry Online.app here: "./Mac/_builds/app/Infantry Online.app"
>
> 3. Run the "./Mac/buildPackageDMG.sh" script in the terminal and it will build a .pkg installer file here: "./Mac/_builds/pkg/" and a distributable dmg file here: "./Mac/_builds/dmg/"
>
</details>

<details>
  <summary>Installing the Game (with Screenshots)</summary>

>
> 1. Open the **DMG Volume Icon** on your desktop
>![DMG Volume](Mac/_screenshots/DMGVolume.png)
>
> 2. Open the **.pkg** file by Control-Click and choosing "Open" in the contextual menu
>![DMG Installer Window](Mac/_screenshots/DMGInstallerWindow.png)
>
</details>

## GNU/Linux
**Any Distro that WINE supports**

<details>
  <summary>Running the PlayOnLinux Script (with Screenshots)</summary>
  
>
> **Prerequisites**
> 
> 1. *[Download & Install]* PlayOnLinux ([https://www.playonlinux.com](https://www.playonlinux.com)), usually available with whatever linux default software distribution app you have. (ie: "Ubuntu Software" for Ubuntu, "Pamac Add/Remove Software" for Manjaro).
> 
> 
> **Step By Step**
>
> 1. Download the "./Linux/play-on-linux-infantry-online.sh" Script from this repo (Make sure to grab the RAW file if downloading through the browser)
>
> 2. Open PlayOnLinux
>
> 3. Open the Tools menu and choose "Run a local script"
>![PlayOnLinux Tools Run Local Script](Linux/_screenshots/POL_Tools-Menu_Run-Local-Script.png)
>
> 4. Navigate to the downloaded "play-on-linux-infantry-online.sh" script.
>
> 5. Follow the prompts and Infantry Online will be installed and ready to play!
>
</details>

<details>
  <summary>Running the Lutris Script (with Screenshots)</summary>

>
> **Prerequisites**
> 
> 1. *[Download & Install]* Lutris ([https://lutris.net](https://lutris.net))
> 
> 
> **Step By Step**
>
> 1. Download the "./Linux/lutris-infantry-online.yaml" Script from this repo (Make sure to grab the RAW file if downloading through the browser)
>
> 2. Open the Terminal
>
> 3. Enter the command `lutris -i lutris-infantry-online.yaml` and hit enter.  Lutris will open.
>
> 4. Click the "Install" button on the right.
> 
>   ![Lutris Install Infantry Online Prompt](Linux/_screenshots/Lutris-Install-Infantry-Online-Prompt.png)
>
> 5. Follow the installer prompts.  Infantry Online installs to your Lutris game library and will be ready to play!
> 
>  ![Lutris Game Library](Linux/_screenshots/Lutris-Game-Library.png)
>
</details>

<!--
<details>
  <summary>(TODO) Building SnapCraft Script</summary>

- TODO
</details>
-->

<details>
  <summary>Generic Manual Installation (Rough Outline)</summary>

>
> **Step By Step**
>
> 1. Download/Install WINE.  (5.0 or higher has been tested)
>     - [https://www.winehq.org](https://www.winehq.org)
> 
> 2. Use winetricks to install the .NET runtime (4.0 minimum required, 4.5.2 also works, have not tested higher)
>     - [https://wiki.winehq.org/Winetricks](https://wiki.winehq.org/Winetricks)
>     - ie: `sh winetricks dotnet40`
> 
> 3. Download the official Infantry Online installer EXE and run it inside WINE
>     - [http://www.freeinfantry.com/download/win/latest/Install-Infantry-Online.exe](http://www.freeinfantry.com/download/win/latest/Install-Infantry-Online.exe)
>     - $ `wine path/to/downloads/Install-Infantry-Online.exe`
> 
> 4. Follow the installer prompts, defaults are good until you get to the "components" screen.  Be sure to choose the "cnc-ddraw, opengl" checkbox instead of the default "cnc-ddraw, dx9" checkbox.  (Both work for linux but you will get higher FPS with the opengl renderer.)
> 
> 5. After it's done, run the launcher with WINE
>     - $ `wine path/to/drive_c/Program Files/InfantryLauncher.exe`
> 
> 6. You are now ready to play!
> 
</details>

## Thanks to all Contributors

#### FreeInfantry
 - Spiff (Shameless shoutout to myself)
 - Realm (AKA Col. Kitty Hawk) for RnD/testing
 - Jovan for helping with source access & website
 - SocketMix for PlayOnLinux manual install guide and testing
 - The whole FreeInfantry team and players

#### CNC-DDraw
 - FunkyFr3sh for his work on cnc-ddraw to support this game for modern windows and WINE

#### Wine
 - Gcenx for his updates on WineSkin (originally created by doh123)
 - The Crossover team for making 32-bit windows apps work on 64-bit macOS

#### Many more people
