#!/bin/bash
# This script is used to execute the 'make distclean' command in the Buildroot directory.
# It automatically finds the 'buildroot' subdirectory located within the script's own directory.

# Get the directory of the currently executing script.
# Use a more robust way to get the script's absolute path and directory.
SCRIPT_PATH="$(readlink -f "$0")"
SCRIPT_DIR="$(dirname "$SCRIPT_PATH")"

BUILDROOT_DIR_NAME="buildroot"
BUILDROOT_PATH="$SCRIPT_DIR/$BUILDROOT_DIR_NAME"

echo "------------------------------------------"
echo "Performing Buildroot project cleanup..."
echo "Script directory: $SCRIPT_DIR"
echo "Expected Buildroot directory: $BUILDROOT_PATH"
echo "------------------------------------------"

# Check if the buildroot directory exists relative to the script's directory.
if [ ! -d "$BUILDROOT_PATH" ]; then
  echo "Error: Buildroot directory '$BUILDROOT_DIR_NAME' not found within the script's directory '$SCRIPT_DIR'."
  echo "Please ensure the script and the Buildroot directory are in the correct relative locations."
  echo "Cleanup failed."
  echo "------------------------------------------"
  exit 1 # Exit with an error code
fi

echo "Entering directory: $BUILDROOT_PATH"
echo "Executing command: make distclean"
echo ""

# Use the -C option to execute the make command in the specified absolute path.
make -C "$BUILDROOT_PATH" distclean

# Check the exit status of the make command.
if [ $? -eq 0 ]; then
  echo ""
  echo "------------------------------------------"
  echo "'make distclean' executed successfully in '$BUILDROOT_PATH'."
  echo "Buildroot project is fully cleaned."
  echo "------------------------------------------"
  exit 0 # Exit successfully
else
  echo ""
  echo "------------------------------------------"
  echo "Error: 'make distclean' failed in '$BUILDROOT_PATH'."
  echo "Please check the output above for details."
  echo "Cleanup failed."
  echo "------------------------------------------"
  exit 1 # Exit with an error code
fi