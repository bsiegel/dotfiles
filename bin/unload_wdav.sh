#!/bin/sh
sudo launchctl stop system/com.microsoft.fresno
sudo launchctl unload /Library/LaunchDaemons/com.microsoft.fresno.plist
sudo launchctl disable system/com.microsoft.fresno
sudo killall -9 dlp_agent 2>/dev/null
