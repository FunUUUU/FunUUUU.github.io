#!/usr/bin/env bash
echo "Backup In Progress..."
cd ..
DATE=`date +%Y%m%d_%H%M%S`
tar -cjf $DATE.tar.bz2 FunUUUU.github.io
mv $DATE.tar.bz2 FunUUUU.github.io
cd FunUUUU.github.io
echo "Cleaning Cache..."
hexo clean --silent
echo "Building And Deploying..."
hexo d -g --silent
echo "Done!"
