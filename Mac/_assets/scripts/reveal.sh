#!/bin/bash
osascript <<EOD
  set thePath to POSIX file "/Applications/Infantry Online.app"
  tell application "Finder" to reveal thePath
EOD
