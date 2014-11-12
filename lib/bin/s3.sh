#!/bin/bash
readonly DIRECTORY="/Volumes/PHOTOS"

# Example s3 usage
# Script will enter sync to S3 if $DIRECTORY exists.
if [ -d "${DIRECTORY}" ]; then
  sudo aws s3 sync  "${DIRECTORY}" s3://drakephoto/
else
  echo "dock:  "${DIRECTORY}" not found, skipping backup."
fi
