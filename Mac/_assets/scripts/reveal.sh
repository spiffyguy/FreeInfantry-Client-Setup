#!/bin/bash
osascript <<EOD
  set thePath to POSIX file "/Applications/FreeInfantry.app"
  tell application "Finder" to reveal thePath
EOD
