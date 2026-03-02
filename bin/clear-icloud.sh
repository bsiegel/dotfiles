#!/bin/bash

read -p "This will delete all iCloud Drive data on this Mac. Do you want to proceed? (y/n) " -n 1 -r
echo    # move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Proceeding with deletion of iCloud Drive data..."
else
    echo "Aborting. No data has been deleted."
    exit 1
fi

rm -rf /Users/brsiegel/Library/Application\ Support/CloudDocs
rm -rf /Users/brsiegel/Library/Application\ Support/FileProvider
rm -rf /Users/brsiegel/Library/CloudStorage
rm -rf /Users/brsiegel/Library/Containers/com.apple.CloudDocs.iCloudDriveFileProvider
rm -rf /Users/brsiegel/Library/Mobile Documents/com~apple~CloudDocs