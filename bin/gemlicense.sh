#!/bin/sh
LIC=$(curl -s https://rubygems.org/gems/$1 | grep -C2 License | grep -oE '<p>[^<>]+' | cut -d'>' -f2)
echo "$1,$LIC"
