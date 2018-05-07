#!/bin/env bash
target=$(pwd)/bin
cd data
LD_LIBRARY_PATH=$target $target/server
