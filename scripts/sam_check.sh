#!/bin/bash
# USAGE: bash sam_check.sh
# DESCRIPTION: prints first line of sam files to see if they are sorted

for file in ~/class/sam/*.sam
do
      head -1 $file
done