#! /bin/sh

name="com.amiunlocked.startup"
read -p "Provide the absolute path to the amiunlocked binary and press [ENTER]: " absolutePath

cat <<- XML > "./$name.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>$name</string>
    <key>Program</key>
    <string>$absolutePath</string>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <false/>
    <key>LaunchOnlyOnce</key>        
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/$name.stdout</string>
    <key>StandardErrorPath</key>
    <string>/tmp/$name.stderr</string>
    <key>UserName</key>
    <string>$(whoami)</string>
    <key>GroupName</key>
    <string>$(groups $(whoami) | cut -d' ' -f1)</string>
    <key>InitGroups</key>
    <true/>
  </dict>
</plist>
XML
