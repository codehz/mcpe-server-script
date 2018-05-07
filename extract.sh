#!/bin/env bash
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 minecraft.apk"
	exit 1
fi
rm -rf data
mkdir -p data
mkdir -p games
touch games/server.properties
unzip $1 -d data
cd data
ln -s ../games .
ln -s ./games/server.properties .
mkdir -p libs && cd libs
ln -s ../lib/x86/libminecraftpe.so libminecraftpe.so
