#!/bin/sh

# Make sure Sophos is removed
if [ -f /Applications/Sophos\ Anti-Virus.app ]; then
    echo "Run /Applications/Remove Sophos Endpoint.app first!"
    exit 1
fi

# Create empty file in place of the real app
sudo touch /Applications/Sophos\ Anti-Virus.app
# Deny write to all
sudo chmod 444 /Applications/Sophos\ Anti-Virus.app
# Add an ACL to deny delete, write, writesecurity, append, chown
sudo chmod +a "everyone deny delete,writesecurity,write,append,chown" /Applications/Sophos\ Anti-Virus.app
# Set the System attribute
sudo SetFile -a S /Applications/Sophos\ Anti-Virus.app
# Set the Locked attribute
sudo SetFile -a L /Applications/Sophos\ Anti-Virus.app
# Set the user-immutable flag
sudo chflags uchg /Applications/Sophos\ Anti-Virus.app
# Set the system-immutable flag
sudo chflags schg /Applications/Sophos\ Anti-Virus.app
