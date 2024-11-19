#!/bin/bash

svn="/usr/bin/svn"
svn_user="etindns1"
svn_pass="google99$"
# svn_home="svn://etinsyssvr.et.local"
svn_home="svn://ind1s01mtasvn01.xt.local"
svn_proj="dns/dns"
dns_home="/var/named/chroot/etc/namedb"

cd $dns_home

lrev=`$svn info --username=$svn_user --password=$svn_pass --non-interactive | egrep "Last Changed Rev" | awk '{ print $4}' | tr -d [:space:]`
srev=`$svn info --username=$svn_user --password=$svn_pass --non-interactive ${svn_home}/${svn_proj}/trunk | egrep "Last Changed Rev" | awk '{ print $4}' | tr -d [:space:]`

if [ "$lrev" -lt "$srev" ]; then
  $svn update --username=$svn_user --password=$svn_pass --force --non-interactive
fi

${dns_home}/bin/dnsreload.sh