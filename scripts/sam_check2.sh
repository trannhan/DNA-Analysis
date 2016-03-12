#!/bin/bash
# USAGE: bash sam_check.sh sam_files
# DESCRIPTION: prints first line of sam files to see if they are sorted

for file in $*
do
      head -1 $file
done