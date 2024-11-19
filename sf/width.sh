# script : width.bash
# 2012
#
#
# pass in unique poolname, get NAT / CR address width
# If you do not pass in a stack number this thing looks in ~/svn/mta/source/Address_Map.txt.
# If you do pass in a stack number it looks in /tmp/address-maps for the appropriate stack specific address map.
#


#the following fails on pools with xt.local in the name
#grep -ih "$1" ~/svn/mta/source/Address_Map.txt | grep -v "#" | grep -v xt.local > new-addresses.txt;

#echo "here is what we see"
#echo $1

if [ -z "$2" ]
  then
  # No argument supplied so it's local
  #grep -ih "$1" ~/svn/mta/source/Address_Map.txt | grep -v "#" | grep "\.\[" > new-addresses.txt;
  grep -ihw "$1" /tmp/address-maps/Address_Map.txt* | grep -v "#" | grep "\.\[" > new-addresses.txt;
else
  # We grab every single address line for the pool name passed in. This would find over 500 lines for DC Pool 3 for example
  # and those 500+ lines are accumulated in new-addresses.txt
    case "$2" in
       p1*) grep -ih "$1" /tmp/address-maps/Address_Map.txt-s1 | grep -v "#" | grep "\.\[" > new-addresses.txt ;;
        1*) grep -ih "$1" /tmp/address-maps/Address_Map.txt-s1 | grep -v "#" | grep "\.\[" > new-addresses.txt ;;
        2*) grep -ih "$1" /tmp/address-maps/Address_Map.txt-s2 | grep -v "#" | grep "\.\[" > new-addresses.txt ;;
        4*) grep -ih "$1" /tmp/address-maps/Address_Map.txt-s4 | grep -v "#" | grep "\.\[" > new-addresses.txt ;;
        5*) grep -ih "$1" /tmp/address-maps/Address_Map.txt-s5 | grep -v "#" | grep "\.\[" > new-addresses.txt ;;
        6*) grep -ih "$1" /tmp/address-maps/Address_Map.txt-s6 | grep -v "#" | grep "\.\[" > new-addresses.txt ;;
    nvidv*) echo "under construction" ;;
    inidv*) echo "under construction" ;;
        *) return 1 ;;
    esac
fi


# 1) strip front of the output up to first comma
# 2) get rid of "," separator and replace it with tab

cat new-addresses.txt | cut -d, -f2,3 | sed "s/,/       /g" > cr.txt


cat cr.txt | cut -d[ -f2 | cut -d] -f1 > tmp.tmp
for i in `cat tmp.tmp`; do let SUBTR=$i; echo $SUBTR; done

rm new-addresses.txt
rm cr.txt
rm tmp.tmp