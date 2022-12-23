#!/bin/bash

read -r -p "Enter your commit message: " message
#echo "Commit message: $message"
git status
git add -A
git commit -m "$message"

echo "Pushing to remote..."
git push origin master
echo "Done."
