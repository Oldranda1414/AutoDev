#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR

ollama serve &

ollama pull mxbai-embed-large

sbt run

pkill -f 'ollama'
