#!/bin/bash

# This scripts injects an email to a specified MTA/VMTA.
# It uses the swaks utility to send the email.
# Arguments are read interactively from the user.
# These arguments are also saved in a config file ($HOME/.inject.conf) and can be reused next time the script is run.

# check for swaks
command -v swaks >/dev/null 2>&1 || { echo -e >&2 "\nCan't find the 'swaks' utility. Aborting.\nInstall it with:\n\tsudo yum install swaks\n"; exit 1; }

# read saved values from config file
if [ -f $HOME/.inject.conf ]; then
    source $HOME/.inject.conf
fi

# read arguments from user defaulting to saved values
echo -e "\n>>> Enter arguments (press enter to accept default shown in parenthesis):\n"

read -p "MTA ($mta): " input
mta=${input:-$mta}

read -p "VMTA ($vmta): " input
vmta=${input:-$vmta}

read -p "From ($from): " input
from=${input:-$from}

read -p "To ($to): " input
to=${input:-$to}

read -p "Subj ($subject): " input
subject=${input:-$subject}


# assemble command
CMD="swaks --from $from --to $to --server $mta --header-Subject \"$subject | $mta |  $vmta | $from | $(date --rfc-3339=seconds)\" --header-x-virtual-mta \"$vmta\""

# Wait for user confirmation
echo -e "\n>>> Verify that everything looks good:"

echo -e "\nArguments:\nmta     = '$mta'\nvmta    = '$vmta'\nfrom    = '$from'\nto      = '$to'\nsubject = '$subject'"
echo -e "\nCommand:\n$CMD\n"
read -p ">>> Enter to continue / CTRL-C to abort"

# save arguments to config file
echo -e "mta='$mta'\nvmta='$vmta'\nfrom='$from'\nto='$to'\nsubject='$subject'\n" > $HOME/.inject.conf

# inject email to MTA
# FIXME: should just run $CMD but that doesn't work (looks like something with the quotes)
swaks --from $from --to $to --server $mta --header-Subject "$subject | $mta |  $vmta | $from | $(date --rfc-3339=seconds)" --header-x-virtual-mta: "$vmta"
