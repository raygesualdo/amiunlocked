#! /bin/sh

cp ./com.amiunlocked.startup.plist ~/Library/LaunchAgents/com.amiunlocked.startup.plist
launchctl load -w ~/Library/LaunchAgents/com.amiunlocked.startup.plist
