#!/bin/bash

# Use the environment variable or default to 10
TARGET_REPO=$GITHUB_REPOSITORY
ITERATIONS=${ITER_COUNT:-10}

echo "Starting generation for $TARGET_REPO"

for i in $(seq 1 $ITERATIONS); do
  echo "Step $i: Making Public"
  gh api -X PATCH "/repos/$TARGET_REPO" -f visibility=public --silent
  
  echo "Step $i: Making Private"
  gh api -X PATCH "/repos/$TARGET_REPO" -f visibility=private --silent
  
  # GitHub SaaS has aggressive secondary rate limits for visibility changes.
  # If you get 403 errors, increase this sleep.
  sleep 2
done
