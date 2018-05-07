#!/bin/env bash
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 minecraft.apk"
	exit 1
fi
rm -rf data
mkdir -p data
unzip $1 -d data
cd data
mkdir -p libs && cd libs
ln -s ../lib/x86/libminecraftpe.so libminecraftpe.so
