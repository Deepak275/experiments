
#!/bin/ksh
# -----------------------------------------------------------------------------
# KSH script
# Operations Utility Script
# Date : 11/30/19
# Author: Dave Nelis
# -----------------------------------------------------------------------------

trap "" 1 2 3

BIN=/usr/bin
SCRIPT=/usr/local/scripts


cat /dev/null >  nodomain
sfmc="/home/etapp/svn/dns/master/customer/"
client="/home/etapp/svn/dns/client_hosted/"
filename="/home/etapp/svn/dns/image_template.csv"

while read file
do
        main=`echo ${file} | awk -F, '{ print $1 }'`
        echo $main | cut -f1,2 -d" " | sed -e "s/^M/ /" >> ssl.image.tmp
done < $filename
while read file
do
        domain=`echo ${file} | awk -F" " '{ print $1}' | cut -f1 -d" "`
        certificate=`echo ${file} | awk -F" " '{ print $2}' | cut -f2 -d" "`

### At this point we have determined the domain name and the certificate type ###
echo $domain

if [ -f $sfmc$domain ]; then

                sed -i 's/image/;image/' $sfmc$domain
                sed -i '/;image/a image           IN CNAME        '$certificate'' $sfmc$domain

        else
        if [ -f $client$domain".txt" ]; then

                sed -i 's/image/;image/' $client$domain.txt
                sed -i '/;image/a image           IN CNAME        '$certificate'' $client$domain.txt

        else
                echo "Error No DNS Zone file found for $domain" >> nodomain
        fi
fi
done < ssl.image.tmp

cat nodomain
rm -f ssl.image.tmp
rm -f tmptmp
rm -f serial.tmp
rm -f serial.tmp1

echo "Finished"

