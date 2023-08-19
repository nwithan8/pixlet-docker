#!/bin/bash

PIXLET_DIRECTORY="/files"

EXAMPLE_FILE="$PIXLET_DIRECTORY/hello_world.star"

mkdir "$PIXLET_DIRECTORY"

curl -sSLf -o "$EXAMPLE_FILE" "https://raw.githubusercontent.com/tidbyt/pixlet/main/examples/hello_world.star"

/usr/bin/pixlet/pixlet serve "$EXAMPLE_FILE" -i 0.0.0.0
