
#!/bin/ksh
# -----------------------------------------------------------------------------
# KSH script
# Operations Utility Script
# Date : 09/10/19
# Author: Dave Nelis
# -----------------------------------------------------------------------------

trap "" 1 2 3

BIN=/usr/bin
SCRIPT=/usr/local/scripts


B=`$BIN/tput bold`
N=`$BIN/tput sgr0`
R=`$BIN/tput rev`
I=`$BIN/tput blink`

Anykey()
{
echo -e "Press the <Return> Key to Continue \c"
read anykey
return
}

Both_Area()
{

year=`date +%Y`
month=`date +%m`
day=`date +%d`
today="$year$month$day"

cat /dev/null >  nodomain
sfmc="/home/etapp/svn/dns/master/customer/"
client="/home/etapp/svn/dns/client_hosted/"
reversedns="/home/etapp/svn/dns/master/reverse/"
filename="/home/etapp/svn/dns/SSL_template.csv"

while read file
do
        main=`echo ${file} | awk -F, '{ print $1 }'`
/ /" >> ssl.dns.tmp| cut -f2,3,4 -d" " | sed -e "s/
done < $filename

while read file
do
        certificate=`echo ${file} | awk -F" " '{ print $1}' | cut -f1 -d.`
        cert=`echo ${file} | awk -F" " '{ print $1}' | cut -f1 -d" "`
        domain=`echo ${file} | awk -F" " '{ print $1}' | cut -f2- -d.`
        vip=`echo ${file} | awk -F" " '{ print $3}'`
        vip1=`echo $vip |cut -f1 -d.`
        vip2=`echo $vip |cut -f2 -d.`
        vip3=`echo $vip |cut -f3 -d.`
        vip4=`echo $vip |cut -f4 -d.`
        rdns=$vip3"."$vip2"."$vip1".in-addr.arpa"
        tmpentry=$vip4".mta.exacttarget.com."
        newentry=$cert"."

### At this point we have determined the domain name and the certificate type ###
### Add z and dd in this area

if [ -f $sfmc$domain ]; then
# ------- Changing the Serial Number for the Domain  ---------
#       grep Serial $sfmc$domain | awk ' {print $1} ' > serial.tmp
#       serial=`cat serial.tmp`
#       serial1=`cut -c1-8 serial.tmp`
#       counter=`cut -c9-10 serial.tmp`

#if [ $serial1 = $today ]
#        then
#        serial2=$today
#        counter1=`expr $counter + 1 `
#        counter2=`printf "%02d\n" $counter1`
#else
#        serial2=$today
#        counter2="00"
#fi

#newserial=$serial2$counter2
#sed -i "s/$serial/$newserial/" "$sfmc$domain"

        case $certificate in
        pages)

                sed -i 's/pages/;pages/' $sfmc$domain
                sed -i '/;pages/a pages           IN A            '$vip'' $sfmc$domain
                ;;
        click)
                sed -i 's/click/;click/' $sfmc$domain
                sed -i '/;click/a click           IN A            '$vip'' $sfmc$domain
                ;;
        cloud)
                sed -i 's/cloud/;cloud/' $sfmc$domain
                sed -i '/;cloud/a cloud           IN A            '$vip'' $sfmc$domain
                ;;
        view)
                sed -i 's/view/;view/' $sfmc$domain
                sed -i '/;view/a view            IN A            '$vip'' $sfmc$domain
                ;;
        esac

        else
        if [ -f $client$domain".txt" ]; then
# ------- Changing the Serial Number for the Domain  ---------
#grep Serial $client$domain".txt" | awk ' {print $2} ' > serial.tmp
#serial=`cat serial.tmp`
#serial1=`cut -c1-8 serial.tmp`
#counter=`cut -c9-10 serial.tmp`

#if [ $serial1 = $today ]
#        then
#        serial2=$today
#        counter1=`expr $counter + 1 `
#        counter2=`printf "%02d\n" $counter1`
#else
#        serial2=$today
#        counter2="00"
#fi

#newserial=$serial2$counter2
#sed -i "s/$serial/$newserial/" "$client$domain.txt"

        case $certificate in
        pages)

                sed -i 's/pages/;pages/' $client$domain.txt
                sed -i '/;pages/a pages           IN A            '$vip'' $client$domain.txt
                ;;
        click)
                sed -i 's/click/;click/' $client$domain.txt
                sed -i '/;click/a click           IN A            '$vip'' $client$domain.txt
                ;;
        cloud)
                sed -i 's/cloud/;cloud/' $client$domain.txt
                sed -i '/;cloud/a cloud           IN A            '$vip'' $client$domain.txt
                ;;
        view)
                sed -i 's/view/;view/' $client$domain.txt
                sed -i '/;view/a view            IN A            '$vip'' $client$domain.txt
                ;;
        esac

        else
                echo "Error No DNS Zone file found for $domain" >> nodomain
        fi
fi

#  -------- Changing the rDNS entry --------

#grep Serial $reversedns$rdns | awk ' {print $1} ' > serial.tmp1
#serial=`cat serial.tmp1`
#serial1=`cut -c1-8 serial.tmp1`
#counter=`cut -c9-10 serial.tmp1`

#if [ $serial1 = $today ]
#        then
#        serial2=$today
#        counter1=`expr $counter + 1 `
#        counter2=`printf "%02d\n" $counter1`
#else
#        serial2=$today
#        counter2="00"
#fi
#
#       newserial=$serial2$counter2
#       sed -i "s/$serial/$newserial/" "$reversedns$rdns"

        grep $tmpentry $reversedns$rdns | awk ' {print $4} ' > tmptmp
        prefix=`head -1 tmptmp | cut -c1-2`
        oldentry=`cat tmptmp | cut -f1 -d" "`
        oldentry1=$prefix$tmpentry
        oldentry2=`head -1 tmptmp`
sed -i "s/$oldentry2/$newentry/" "$reversedns$rdns"
done < ssl.dns.tmp

Anykey
}

Forward_Area()
{
year=`date +%Y`
month=`date +%m`
day=`date +%d`
today="$year$month$day"

cat /dev/null >  nodomain
sfmc="/home/etapp/svn/dns/master/customer/"
client="/home/etapp/svn/dns/client_hosted/"
reversedns="/home/etapp/svn/dns/master/reverse/"
filename="SSL_template.csv"

while read file
do
        main=`echo ${file} | awk -F, '{ print $1 }'`
/ /" >> ssl.dns.tmp| cut -f2,3,4 -d" " | sed -e "s/
done < $filename
while read file
do
        certificate=`echo ${file} | awk -F" " '{ print $1}' | cut -f1 -d.`
        cert=`echo ${file} | awk -F" " '{ print $1}' | cut -f1 -d" "`
        domain=`echo ${file} | awk -F" " '{ print $1}' | cut -f2- -d.`
        vip=`echo ${file} | awk -F" " '{ print $3}'`
        vip1=`echo $vip |cut -f1 -d.`
        vip2=`echo $vip |cut -f2 -d.`
        vip3=`echo $vip |cut -f3 -d.`
        vip4=`echo $vip |cut -f4 -d.`
        rdns=$vip3"."$vip2"."$vip1".in-addr.arpa"
        tmpentry=$vip4".mta.exacttarget.com."
        newentry=$cert"."

### At this point we have determined the domain name and the certificate type ###

if [ -f $sfmc$domain ]; then
# ------- Changing the Serial Number for the Domain  ---------
#        grep Serial $sfmc$domain | awk ' {print $1 } ' > serial.tmp
#        serial=`cat serial.tmp`
#        serial1=`cut -c1-8 serial.tmp`
#        counter=`cut -c9-10 serial.tmp`

#if [ $serial1 = $today ]
#        then
#        serial2=$today
#        counter1=`expr $counter + 1 `
#        counter2=`printf "%02d\n" $counter1`
#else
#        serial2=$today
#        counter2="00"
#fi

#        newserial=$serial2$counter2
#        sed -i "s/$serial/$newserial/" "$sfmc$domain"
        case $certificate in
        pages)

                sed -i 's/pages/;pages/' $sfmc$domain
                sed -i '/;pages/a pages           IN A            '$vip'' $sfmc$domain
                ;;
        click)
                sed -i 's/click/;click/' $sfmc$domain
                sed -i '/;click/a click           IN A            '$vip'' $sfmc$domain
                ;;
        cloud)
                sed -i 's/cloud/;cloud/' $sfmc$domain
                sed -i '/;cloud/a cloud           IN A            '$vip'' $sfmc$domain
                ;;
        view)
                sed -i 's/view/;view/' $sfmc$domain
                sed -i '/;view/a view            IN A            '$vip'' $sfmc$domain
                ;;
        esac

        else
        if [ -f $client$domain".txt" ]; then
# ------- Changing the Serial Number for the Domain  ---------
#        grep Serial $client$domain".txt" | awk ' {print $2 } ' > serial.tmp
#        serial=`cat serial.tmp`
#        serial1=`cut -c1-8 serial.tmp`
#        counter=`cut -c9-10 serial.tmp`
#if [ $serial1 = $today ]
#        then
#        serial2=$today
#        counter1=`expr $counter + 1 `
#        counter2=`printf "%02d\n" $counter1`
#else
#        serial2=$today
#        counter2="00"
#fi

#newserial=$serial2$counter2
#sed -i "s/$serial/$newserial/" "$client$domain.txt"
        case $certificate in
        pages)

                sed -i 's/pages/;pages/' $client$domain.txt
                sed -i '/;pages/a pages           IN A            '$vip'' $client$domain.txt
                ;;
        click)
                sed -i 's/click/;click/' $client$domain.txt
                sed -i '/;click/a click           IN A            '$vip'' $client$domain.txt
                ;;
        cloud)
                sed -i 's/cloud/;cloud/' $client$domain.txt
                sed -i '/;cloud/a cloud           IN A            '$vip'' $client$domain.txt
                ;;
        view)
                sed -i 's/view/;view/' $client$domain.txt
                sed -i '/;view/a view            IN A            '$vip'' $client$domain.txt
                ;;
        esac

        else
                echo "Error No DNS Zone file found for $domain" >> nodomain
        fi
fi
done < ssl.dns.tmp

}


Reverse_Area()
{
year=`date +%Y`
month=`date +%m`
day=`date +%d`
today="$year$month$day"

cat /dev/null >  nodomain
sfmc="/home/etapp/svn/dns/master/customer/"
client="/home/etapp/svn/dns/client_hosted/"
reversedns="/home/etapp/svn/dns/master/reverse/"
filename="SSL_template.csv"

while read file
do
        main=`echo ${file} | awk -F, '{ print $1 }'`
/ /" >> ssl.dns.tmp| cut -f2,3,4 -d" " | sed -e "s/
done < $filename

while read file
do
        certificate=`echo ${file} | awk -F" " '{ print $1}' | cut -f1 -d.`
        cert=`echo ${file} | awk -F" " '{ print $1}' | cut -f1 -d" "`
        domain=`echo ${file} | awk -F" " '{ print $1}' | cut -f2- -d.`
        vip=`echo ${file} | awk -F" " '{ print $3}'`
        vip1=`echo $vip |cut -f1 -d.`
        vip2=`echo $vip |cut -f2 -d.`
        vip3=`echo $vip |cut -f3 -d.`
        vip4=`echo $vip |cut -f4 -d.`
        rdns=$vip3"."$vip2"."$vip1".in-addr.arpa"
        tmpentry=$vip4".mta.exacttarget.com."
        newentry=$cert"."

#  -------- Changing the rDNS entry --------

#grep Serial $reversedns$rdns | awk ' {print $1} ' > serial.tmp1
#serial=`cat serial.tmp1`
#serial1=`cut -c1-8 serial.tmp1`
#counter=`cut -c9-10 serial.tmp1`

#if [ $serial1 = $today ]
#        then
#        serial2=$today
#        counter1=`expr $counter + 1 `
#        counter2=`printf "%02d\n" $counter1`
#else
#        serial2=$today
#        counter2="00"
#fi

#newserial=$serial2$counter2
#echo "5"
#sed -i "s/$serial/$newserial/" "$reversedns$rdns"

grep $tmpentry $reversedns$rdns | awk ' {print $4} ' > tmptmp
        prefix=`head -1 tmptmp | cut -c1-2`
        oldentry=`cat tmptmp | cut -f1 -d" "`
        oldentry1=$prefix$tmpentry
                                oldentry2=`head -1 tmptmp`
sed -i "s/$oldentry2/$newentry/" "$reversedns$rdns"
done < ssl.dns.tmp

Anykey
}


Cleanup_Area()
{
cat nodomain
rm -f ssl.dns.tmp
rm -f tmptmp
rm -f serial.tmp
rm -f serial.tmp1

echo "Finished"
}


SSL_Menu()
{
trap "echo "";SSL_menu "  INT KILL QUIT TSTP
$BIN/clear
echo -e "                             Current System:  ${B}${I}`/bin/hostname` ${N}"
echo
echo
echo
echo
echo
        echo -e "                   ${B}SSL DNS Update Options  ${N}



        ${B}(1)${N}  Update Both Forward and Reverse DNS Entries

        ${B}(2)${N}  Update Forward DNS Entries Only

        ${B}(3)${N}  Update Reverse DNS Entries Only


        ${B}(E)${N}             EXIT



                Choose an option or ${B} E ${N}to Exit:\c"
read boards
case $boards in
        1)
                Both_Area;Cleanup_Area;SSL_Menu;;
        2)
                Forward_Area;Cleanup_Area;SSL_Menu;;
        3)
                Reverse_Area;Cleanup_Area;SSL_Menu;;
        e|E)
                exit;;

        *)      echo
                SSL_Menu;;
esac
}
SSL_Menu









# Rewrtie in python
#!/usr/bin/env python3
# -----------------------------------------------------------------------------
# Python script
# Operations Utility Script
# Date : 09/10/19
# Author: Dave Nelis (translated to Python)
# -----------------------------------------------------------------------------

import os
import subprocess
from datetime import datetime

BIN = "/usr/bin"
SCRIPT = "/usr/local/scripts"

def any_key():
    input("Press the <Return> Key to Continue")

def update_dns_file(domain, cert, vip, file_path):
    if os.path.isfile(file_path):
        vip_entry = f"{vip} IN A {vip}"
        if cert in ['pages', 'click', 'cloud', 'view']:
            with open(file_path, 'r+') as f:
                content = f.read()
                content = content.replace(cert, f";{cert}")
                content += f"\n{cert}           IN A            {vip}\n"
                f.seek(0)
                f.write(content)
                f.truncate()
    else:
        with open('nodomain', 'a') as nodomain_file:
            nodomain_file.write(f"Error No DNS Zone file found for {domain}\n")

def both_area():
    today = datetime.today().strftime('%Y%m%d')

    # Paths
    sfmc = "/home/etapp/svn/dns/master/customer/"
    client = "/home/etapp/svn/dns/client_hosted/"
    reversedns = "/home/etapp/svn/dns/master/reverse/"
    filename = "/home/etapp/svn/dns/SSL_template.csv"

    with open('nodomain', 'w'), open(filename) as csv_file:
        for line in csv_file:
            fields = line.split(',')
            domain = fields[0]
            cert = fields[1]
            vip = fields[2]
            vip_parts = vip.split('.')
            rdns = f"{vip_parts[2]}.{vip_parts[1]}.{vip_parts[0]}.in-addr.arpa"
            tmpentry = f"{vip_parts[3]}.mta.exacttarget.com."
            newentry = f"{cert}."

            # Determine if the domain exists and update DNS
            sfmc_file_path = os.path.join(sfmc, domain)
            client_file_path = os.path.join(client, f"{domain}.txt")

            if os.path.isfile(sfmc_file_path):
                update_dns_file(domain, cert, vip, sfmc_file_path)
            elif os.path.isfile(client_file_path):
                update_dns_file(domain, cert, vip, client_file_path)
            else:
                with open('nodomain', 'a') as nodomain_file:
                    nodomain_file.write(f"Error No DNS Zone file found for {domain}\n")

            # Update reverse DNS
            reversedns_file_path = os.path.join(reversedns, rdns)
            if os.path.isfile(reversedns_file_path):
                with open(reversedns_file_path, 'r+') as f:
                    content = f.read()
                    prefix = tmpentry[:2]
                    oldentry = tmpentry
                    content = content.replace(oldentry, newentry)
                    f.seek(0)
                    f.write(content)
                    f.truncate()

    any_key()

def forward_area():
    # Similar to both_area but only for forward DNS entries
    pass

def reverse_area():
    # Similar to both_area but only for reverse DNS entries
    pass

def cleanup_area():
    # Cleanup temporary files
    os.remove('ssl.dns.tmp')
    os.remove('tmptmp')
    os.remove('serial.tmp')

    print("Finished")

def ssl_menu():
    while True:
        print(f"\nCurrent System: {subprocess.getoutput('/bin/hostname')}")
        print("\nSSL DNS Update Options\n")
        print("(1)  Update Both Forward and Reverse DNS Entries")
        print("(2)  Update Forward DNS Entries Only")
        print("(3)  Update Reverse DNS Entries Only")
        print("(E)  EXIT\n")

        choice = input("Choose an option or E to Exit: ").lower()

        if choice == '1':
            both_area()
            cleanup_area()
        elif choice == '2':
            forward_area()
            cleanup_area()
        elif choice == '3':
            reverse_area()
            cleanup_area()
        elif choice == 'e':
            break
        else:
            print("Invalid option, try again.")

if __name__ == "__main__":
    ssl_menu()
