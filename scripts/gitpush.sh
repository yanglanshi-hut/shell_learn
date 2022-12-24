#!/bin/bash

read -p "Enter your commit message: " message
#echo "Commit message: $message"
git status
echo "Adding all files..."
git add -A
echo "Committing..."
git commit -m "$message"
echo "Pushing to remote..."
git push
echo "Done."
