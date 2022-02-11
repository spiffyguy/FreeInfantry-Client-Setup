# Infantry Online Client Setup/Installer Files

**Download the latest built, ready to run, clients at: [http://freeinfantry.com](http://freeinfantry.com)**

Setup/Installer source files for the Infantry Online game:

## Windows

> ### Prerequisites
>
> - Windows 7 SP1 or later

<details>
  <summary>(TODO) Building the Installer</summary>

> **Download/Install First**
> 
> - Visual Studio 2019 Community Edition ([https://visualstudio.microsoft.com/vs/older-downloads/](https://visualstudio.microsoft.com/vs/older-downloads/))

- (TODO) More things...
</details>

## macOS

> ### Prerequisites
>
> - macOS 10.13 (High Sierra) or later

<details>
  <summary>(TODO) How to wrap the Windows .exe into a Mac .app with WineSkin</summary>

> **Download/Install First**
> 
> - WineSkin Wrapper ([https://github.com/Gcenx/WineskinServer](https://github.com/Gcenx/WineskinServer))
> - cnc-ddraw ([https://github.com/CnCNet/cnc-ddraw](https://github.com/CnCNet/cnc-ddraw))

- TODO
</details>

<details>
  <summary>Building the Installer</summary>

> **Download/Install First**
> 
> - Mac "Packages" app ([http://s.sudre.free.fr/Software/Packages/about.html](http://s.sudre.free.fr/Software/Packages/about.html))
> - `brew install create-dmg` ([https://github.com/create-dmg/create-dmg](https://github.com/create-dmg/create-dmg))

 1. Place the built WineSkin wrapped client app here: "./Mac/_build/app/Infantry Online.app"
 2. Run the "./Mac/buildPackageDMG.sh" in the terminal to build a .pkg installer file and a distributable dmg file.
</details>

<details>
  <summary>Screenshots</summary>

![DMG Volume](Mac/_screenshots/DMGVolume.png)
![DMG Installer Window](Mac/_screenshots/DMGInstallerWindow.png)
</details>

## Thanks to all Contributors

#### FreeInfantry
 - Realm (AKA Col. Kitty Hawk) for RnD/testing
 - Jovan for helping with the repo & website
 - The whole FreeInfantry team.

#### CNC-DDraw
 - FunkyFr3sh for his work on cnc-ddraw to support this game

#### Wineskin
 - Gcenx for his updates on WineSkin (originally created by doh123)

#### Many more people
