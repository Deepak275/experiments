#!/bin/bash

if [ -e /tmp/pushlock ]; then
  # do file test to see if pushlock is in /tmp ... meaning someone is running this script right now
  echo
  echo "It appears that someone else is running this script right now. Wait a few and try again."
  echo "If this condition persists, take a look at /tmp/pushlock. You may need to rm it."
  echo "----------------------------------------------------------------------------------------"
  echo
  ls -alF /tmp/pushlock
  echo
  exit
else
  touch /tmp/pushlock
  chmod 777 /tmp/pushlock
fi


dns_home="/var/named/chroot/etc/namedb"

echo
echo
echo "Running ns1a reload first. "
echo
echo "When it finishes you can quit (if there are problems), or then run the rest sequentially or in parallel."
echo "When run in parallel the feedback will be much faster and it will be intermixed for the remaining servers."
echo
echo
echo ns1a
ssh ns1a "sudo ${dns_home}/bin/receive"
echo
echo

PS3='  Please enter your choice (hit enter to redraw menu) '
LIST="Parallel   Sequential   Quit"
select OPT in $LIST
do
clear
if [ $OPT = "Parallel" ] &> /dev/null
then
  #for server in ns1b ns2a ns2b ns3a ns3b ; do
  for server in `cat ~/svn/dns/bin/all_dns`; do
    echo $server
    ssh $server "sudo ${dns_home}/bin/receive" &
  done
  break
elif [ $OPT = "Sequential" ] &> /dev/null
then
  #for server in ns1b ns2a ns2b ns3a ns3b ; do
  for server in `cat ~/svn/dns/bin/all_dns`; do
    echo $server
    ssh $server "sudo ${dns_home}/bin/receive"
  done
  break
elif [ $OPT = "Quit" ] &> /dev/null
then
  echo
  echo Exiting
  echo
  break
fi
done

echo
echo "Patience. Sleeping for 15 seconds before we clear the push lock file from /tmp."
echo
sleep 15
rm -f /tmp/pushlock