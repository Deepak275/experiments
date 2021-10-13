#!/bin/bash
echo "USER=$USER"
echo "HOME=$HOME"
echo "OSNAME=$OSNAME"

echo "${@: -1}"
last_arg=${@: -1}

f1=21
de1="33"

if [ "$f1" == "21" ] || [ "$de1" == "33" ]; then
  echo "somthing"
fi

# echo $last_arg