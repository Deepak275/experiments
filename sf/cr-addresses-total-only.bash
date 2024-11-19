# pass in poolname, get number of sending IPs in pool
# meadows
# 2015
#


grep -iwh "$1" /tmp/address-maps/Address_Map.txt* | grep -v "#" | grep "\.\[" > new-addresses.txt;

#echo
#echo "Here's the full output"
#echo "----------------------"
#cat new-addresses.txt
#echo
#echo

# 1) strip front of the output up to first comma
# 2) get rid of "," separator and replace it with tab

cat new-addresses.txt | cut -d, -f2,3 | sed "s/,/       /g" > cr.txt

#echo "Here's what we put in the CR"
#echo "----------------------------"
#cat cr.txt

echo
echo "Total Public IPs is"
echo "-------------------"
cat cr.txt | wc -l

cp cr.txt cr.txt-safe