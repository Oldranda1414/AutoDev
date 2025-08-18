#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

julia $SCRIPT_DIR/hello.jl

julia $SCRIPT_DIR/hello.jl
