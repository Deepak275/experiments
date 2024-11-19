#!/bin/bash
# dnsreload.sh
# Written by Matt Barton <mbarton@exacttarget.com> before 2010
# modified by Meadows between 2010 - 2019
#
# 2008-06-25: Updated for use within Red Hat EL 4.
# 2011-03-09: Updated to support dynamic DNS.
# 2011-09-29: Updated to support split view of exacttarget.com
# 2012-04-26: Updated to support a third split view of exacttarget.com
#

############################
### Script Configuration ###
############################

hostname=$(hostname -s)
chroot_dir="/var/named/chroot"
work_dir="etc/namedb"
conf_file_master="named.conf.${hostname}"
conf_file="named.conf"
tmp_file="/tmp/zones.tmp"
key_file="named.conf.keys"

zone_conf_files=( named.conf.corp named.conf.cust )
zone_conf_directories=( master/corporate master/customer )

########################
### Script Functions ###
########################

function truncate_file {
    file=$1
    if [ -f $file ]; then rm $file; touch $file; fi
}

function set_secure_perms {
# looking in /var/named/chroot/*
# skipping proc and dev dirs
# skipping files that are in the dir
  local dir=$1
  for i in $(echo $dir/*); do
    [ "$i" = "$dir/proc" -o "$i" = "$dir/dev" ] && continue
    [ -f "$i" ] && continue
    find $i -type d -print 2>/dev/null | xargs chmod u=rwx,go=rx 2>/dev/null
    find $i -type f -print 2>/dev/null | xargs chmod u=rw,go=r 2>/dev/null
    find $i -type f -a -name "*.sh" -print 2>/dev/null | xargs -r chmod u+x 2>/dev/null
    done
  chmod ugo+x $dir/$work_dir/bin/* 2>/dev/null
  chown root:named $dir/$work_dir/$key_file && chmod g+w $dir/$work_dir/$key_file 2>/dev/null
  chown -R named:named $dir/$work_dir/slave && chmod g+w $dir/$work_dir/slave 2>/dev/null
  chown -R named:named $dir/$work_dir/master/dynamic && chmod g+w $dir/$work_dir/master/dynamic 2>/dev/null
  chown -R named:named $dir/var 2>/dev/null
  # Weird.  Get complaints if this isn't owned by named
  chown named:named $dir/etc 2>/dev/null
  }

function kick_bind {
  if ( pgrep named >& /dev/null ); then
    /usr/bin/logger -t named "######################## RELOAD ########################"
    /usr/sbin/rndc reload
    else
    /usr/bin/logger -t named "################# RESTART (CHECK LOGS) #################"
    /sbin/service named start
    fi
  }


function handle_sig0_key {
  # SIG(0): nothing special to do.  The key will be a DNSKEY RR in the zone file.
  local zone_file=$1
  local dynamic=0
  keyentity=$(grep "DNSKEY" $conf)
  keyentity=${keyentity#*[      ]}
  dynamic=1
  return $dynamic
  }

function handle_tsig_key {
  # TSIG
  # Check the zone file for two comments:
  #
  # dnssec-keygen -a HMAC-MD5 -b 512 -n HOST -k cotweet.com
  #
  # "; keysecret:<secret>"
  # "; keyentity:<domainname>"
  # If the comments exist, then extract the key contents and the key name, and set up
  # trusted keys in etc/namedb/named.conf.trusted-keys
  local zone_file=$1
  local dynamic=0
  if ( grep "keyentity:" $zone_file >& /dev/null ); then
    keysecret=$(grep "keysecret:" $zone_file)
    keyentity=$(grep "keyentity:" $zone_file)
    keysecret=${keysecret#*:}
    keyentity=${keyentity#*:}
    dynamic=1

    #echo "key ${keyentity}. {" >> $chroot_dir/$work_dir/$key_file
    #echo "    algorithm hmac-md5;" >> $chroot_dir/$work_dir/$key_file
    #echo "    secret \"$keysecret\";" >> $chroot_dir/$work_dir/$key_file
    #echo "    };" >> $chroot_dir/$work_dir/$key_file
    #echo >> $chroot_dir/$work_dir/$key_file
    #echo "Building: $keyentity -> $chroot_dir/$work_dir/$key_file."
    fi
  return $dynamic
  }

function build_zone_conf_file {
  truncate_file $tmp_file
  zone_conf_file=$1
  zone_conf_directory=$2
  domain_list=`ls $zone_conf_directory | grep -v TEMPLATE`

  echo "Building: $zone_conf_directory -> $zone_conf_file."
  domain=`echo $zone_file`
  for zone_file in $domain_list; do
    dynamic=0
    domain=`echo $zone_file`
    echo "zone \"$domain\" {" >> $tmp_file
    echo "    type master;" >> $tmp_file

    # There are two ways to authenticate dynamic DNS update requests: TSIG and SIG(0).
    # As of now, ET doesn't handle SIG(0) because this is an old version of BIND.
    # Nonetheless, there will be two ways to store keys.

    if ( grep "DNSKEY" $zone_conf_directory/$zone_file >& /dev/null ); then
      handle_sig0_key $zone_conf_directory/$zone_file
      elif ( grep "keysecret:" $zone_conf_directory/$zone_file >& /dev/null ); then
      handle_tsig_key $zone_conf_directory/$zone_file
      fi
    dynamic=$?

    if [ "$dynamic" -eq "1" ]; then
      # Since these are dynamic zones, we don't actually want to update
      # them because we'll wipe out updates!  Just copy the basic zone file.
      if [ ! -e "master/dynamic/${zone_file}" ]; then
        if [ ! -d "master/dynamic" ]; then
          mkdir -p master/dynamic
          fi
        cp ${zone_conf_directory}/${zone_file} master/dynamic
        fi

      echo "    update-policy { grant $keyentity. subdomain $zone_file. ANY; };" >> $tmp_file
      echo "    file \"master/dynamic/$zone_file\";" >> $tmp_file
      else

        # Back to plain zones.
        echo "    file \"$zone_conf_directory/$zone_file\";" >> $tmp_file
      fi

    echo "};" >> $tmp_file
    echo >> $tmp_file
  done
  cat $tmp_file > $zone_conf_file
  }

##############
### main() ###
##############

cd $chroot_dir/$work_dir
echo "PWD: $(pwd)"

if [ ! -f $conf_file_master ]; then
        echo "Missing file: $conf_file_master.  Exiting."
        exit 1
    fi

echo "Renaming master file."
cp $conf_file_master $conf_file

truncate_file $chroot_dir/$work_dir/$key_file
for (( i = 0 ; i < ${#zone_conf_directories[@]} ; i++ )); do
    build_zone_conf_file ${zone_conf_files[$i]} ${zone_conf_directories[$i]}
done


###
#
# The following lines added to split exacttarget.com view : internal / external
# The internal views of the exacttarget.com zone file are in master/misc/internal/exacttarget.com.internal
# master/misc/internal/exacttarget.com.internal2
# This changes the reference to exacttarget.com zone file in named.conf.corp.internal and named.conf.corp.internal2
# Easy to make an internal view for any other zone file from here. Just select the domain you want. Copy the zone file to the
# internal path and make a working sed entry. If this begins to grow will generate a txt input file for this.
#
###

#sed 's/master\/corporate\/exacttarget.com\"/master\/misc\/internal\/exacttarget.com.internal\"/' named.conf.corp > named.conf.corp.internal
#sed 's/master\/corporate\/exacttarget.com\"/master\/misc\/internal\/exacttarget.com.internal2\"/' named.conf.corp > named.conf.corp.internal2
#svn ci -m "auto generate new named.conf.corp.internal configs"
cp named.conf.corp named.conf.corp.internal
cp named.conf.corp named.conf.corp.internal2
svn ci -m "auto generate new named.conf.corp.internal configs"



# Set permissions to secure files.
set_secure_perms $chroot_dir

# Run rndc checkconf or something first.
echo -n "Sanity check: "
log="$(/usr/sbin/named-checkconf -z -t $chroot_dir /etc/namedb/named.conf)"
if [ "$?" -gt "0" ]; then
  printf "\033[0;31m%s" "failed.  "
  printf "\033[0m"
  echo "Check /tmp/failed.$$ on $hostname. Goodbye."
  cat > /tmp/failed.$$ << EOF
$log
EOF
  exit 1;
  else
  # Rainbows!
  colors=( 31 32 33 34 35 36 30 31 35 35 35 35 31 )
  letters=( p a s s e d "" \( Y A Y ! \) )
  echo "$hostname"
  for i in {0..12}; do
    printf "\033[1;%sm%1.1s" ${colors[$i]} ${letters[$i]}
  done
  printf "\033[0m"
  printf "\n"
  fi

# Reload (or restart) BIND
kick_bind

echo -e "### LOGS ###"
cat /var/log/messages | grep named | grep -v "loaded serial" | tail -1