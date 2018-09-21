#!/usr/bin/env bash
DATE=`date +%Y%m%d%H%M%S`
echo "Pushing source to GitHub..."
git add .
git commit -m \'$DATE\'
git push
echo "Cleaning Cache..."
hexo clean
echo "Building And Deploying..."
hexo d -g
echo "Running Again to ensure everything is ok..."
echo "Pushing source to GitHub..."
git add .
git commit -m \'$DATE\'
git push
echo "Cleaning Cache..."
hexo clean
echo "Building And Deploying..."
hexo d -g
echo "Done!"

