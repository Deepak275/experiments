#!/bin/bash
wget https://coderbyte.com/api/challenges/logs/web-logs-raw 

cat web-logs-raw| grep "coderbyte heroku/router" | grep MASKED | awk '{print $10}' |  sed -e s/^request_id=// | xargs  bash -c 'echo "$0 [M]"'