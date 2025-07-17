#!/bin/bash

#simple script that runs AutoDev on a test project located at ../temp with provided arguments

# clean temp directory
rm -rf ../temp/*

# add test project structure
echo "some other other contents" > ../temp/someotherotherfile.txt
mkdir ../temp/folder_a
echo "some other contents" > ../temp/folder_a/someotherfile.txt
mkdir ../temp/folder_b
mkdir ../temp/folder_b/folder_c
echo "some contents" > ../temp/folder_b/folder_c/somefile.txt

# run AutoDev
just run ../temp $@
