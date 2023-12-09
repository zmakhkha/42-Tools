#!/bin/bash

# Check if a message argument is provided
if [ $# -eq 0 ]; then
  echo "Please provide a commit message as an argument."
  exit 1
fi

# Git commands
git add .
git commit -m "$1"
git push