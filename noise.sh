#!/bin/bash

TARGET_REPO=$GITHUB_REPOSITORY
ITERATIONS=${ITER_COUNT:-10}

echo "Targeting: $TARGET_REPO"
echo "Generating $((ITERATIONS * 2)) visibility change events..."

for i in $(seq 1 $ITERATIONS); do
  echo "Cycle $i/$ITERATIONS"
  
  # Make Public
  gh api -X PATCH "/repos/$TARGET_REPO" -f visibility=public --silent
  
  # Make Private
  gh api -X PATCH "/repos/$TARGET_REPO" -f visibility=private --silent
  
  # 2s sleep to avoid secondary rate limits on heavy visibility changes
  sleep 2
done
