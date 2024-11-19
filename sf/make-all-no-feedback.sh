# author : meadows
# date: 2015
#
# generate an "all" file in the current directory with a complete list of MTAs ... generally based on an MTA Pool name
# generates simple hostnames

# input - pool name ... or ip address

# if there is no $1 then all is the default
# if $1 is "-ip" then process $2 ... which is an IP address ... this lets you make an input file from an IP address
#


# I only use this function to dump the final results to the screen ... could have used a cat output_file2 after "do_it"
function omm ()
{ command echo ; ls -alF /tmp/omm_data.csv | tail -1; echo ; grep -iw "$@" /tmp/omm_data.csv | sort -t "," -k4 |
cut -d "," -f 1,2,3,4 | tee ~/output-file2; echo; }

# this is where we actually make the "all" file
function do_it ()
{ command grep -iw "$@" /tmp/omm_data.csv | cut -d "," -f 1 -d "." | tee ~/output-file2;  }

#

if [ "$1" == "all" ];  then
   cp /tmp/mtalist all
elif [ "$1" == "-ip" ]; then    # this strips out the pool name from the IP address search
   #echo "testing this silly thing ... to see if life really is good"
   grep -iw "$2" /tmp/address-maps/* | head -1 |  awk -F '[' '{print $2}' | awk -F ']' '{print $1}' > use-this
   # I have the pool name in the "use-this" file now
   input=`cat use-this`
   echo $input
   #omm "$input"
   do_it "$input" > all
else
   #omm "$1"
   do_it "$1" > all
fi
