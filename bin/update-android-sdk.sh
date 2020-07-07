#!/bin/sh
echo y | android-sdk-linux/tools/android update sdk -u -t  extra,platform-tool,tool
echo y | android-sdk-linux/tools/android update sdk -a -u -t $(android-sdk-linux/tools/android list sdk -a | grep 'Android SDK Build-tools' | sed 's/ *\([0-9]\+\)\-.*/\1/' | paste -s -d',')
echo y | android-sdk-linux/tools/android update sdk -a -u -t $(android-sdk-linux/tools/android list sdk -a | grep 'SDK Platform Android.\+API' | grep -v 'Obsolete' | sed 's/ *\([0-9]\+\)\-.*/\1/' | paste -s -d',')
