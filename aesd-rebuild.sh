#!/bin/bash
SCRIPT_FULL_PATH=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_FULL_PATH")

cd ${SCRIPT_DIR}/buildroot
make aesd-assignments-dirclean
cd ${SCRIPT_DIR}
./build.sh
if [ $? -ne 0 ]; then
    echo "Build failed. Please check the output for errors."
    exit 1
fi