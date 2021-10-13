# !/bin/bash -xv
clear
 
# turn on debug mode
set -x
for f in *
do
   file $f
done

a=2
b=3
c=$(( $a + $b ))
# turn OFF debug mode
# set +x
ls

echo $a
# more commands

for VAR in $LIST
do
   echo $VAR
done
