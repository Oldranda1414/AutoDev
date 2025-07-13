#!/bin/bash

#simple script that runs AutoDev on a test project located at ../temp with provided arguments

rm -rf ../temp/*
just run ../temp $@
