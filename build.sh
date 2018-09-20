#!/usr/bin/env bash
DATE=`date +%Y%m%d_%H%M%S`
DATE="Updated at $DATE."
echo "Pushing source to GitHub..."
git add .
git commit -m \"$DATE\"
git push
echo "Cleaning Cache..."
hexo clean --silent
echo "Building And Deploying..."
hexo d -g --silent
echo "Done!"

