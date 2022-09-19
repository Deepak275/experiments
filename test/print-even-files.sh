#!/bin/bash

files=($(ls -l $1 | awk '{print $9}' | cut -f 1 -d '.'))

for i in "${files[@]}"
do
   len=${#i}
   if [[ $len > 4 ]]; then
    ls -l $1 | awk '{print $9}' | grep $i;
   fi
done