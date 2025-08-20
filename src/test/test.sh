#!/usr/bin/env bash

# Get the directory where the script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
WORKSPACE_DIR=$1
MODEL_NAME=$2
PROMPT_PATH=$3
TEST_SCRIPT="$WORKSPACE_DIR/test.sh"
TEMP_SCRIPT="$SCRIPT_DIR/space/test.sh"

# Clean project dir
rm -f $WORKSPACE_DIR/flake.nix
rm -f $WORKSPACE_DIR/flake.lock

git init $WORKSPACE_DIR -q

mv $TEST_SCRIPT $TEMP_SCRIPT

uv --project src run $SCRIPT_DIR/../../src/main/main.py $WORKSPACE_DIR -m $MODEL_NAME -p $PROMPT_PATH -q
AUTODEV_EXIT_CODE=$?

mv $TEMP_SCRIPT $TEST_SCRIPT

# Check if the uv command failed
if [ $AUTODEV_EXIT_CODE -ne 0 ]; then
    echo "AutoDev failed with exit code $AUTODEV_EXIT_CODE. Skipping nix develop."
    exit $AUTODEV_EXIT_CODE
fi

nix develop $WORKSPACE_DIR --command $TEST_SCRIPT
RESULT=$?

exit $RESULT
