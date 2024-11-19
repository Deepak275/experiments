# meadows
# input - need exact pool name
#
# will generate address list ... to show sending IP total
# will generate data to show max pool width possible
# will report number of MTAs in the pool
#

function width () { command bash ~/com/width.bash "$@" | sort | uniq ; }

bash ~/com/cr-addresses-total-only.bash "$1"
bash ~/com/make-all-no-feedback.sh "$1"
echo "Number of MTAs in pool"
echo "----------------------"
cat all | wc -l
echo
echo "Pool Width"
echo "----------"
width "$1"
echo