#!/usr/bin/env bash

# Get the directory where the script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
WORKSPACE_DIR=$1
MODEL_NAME=$2
PROMPT_PATH=$3
TEST_SCRIPT="$WORKSPACE_DIR/test.sh"

# Clean project dir
rm $WORKSPACE_DIR/flake.nix
rm $WORKSPACE_DIR/flake.lock

git init $WORKSPACE_DIR

uv --project src run $SCRIPT_DIR/../../src/main/main.py $WORKSPACE_DIR -m $MODEL_NAME -p $PROMPT_PATH -q

nix develop $WORKSPACE_DIR --command $TEST_SCRIPT
RESULT=$?

echo $RESULT
exit $RESULT
