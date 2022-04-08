#!/bin/bash

set -exo pipefail
LOG_FILE="./output.txt"

pid=$(ps -eo pid,cmd,%mem,%cpu --sort=-%mem|awk 'NR==4'| awk '{print $1}')


port=$(netstat -ltnp | grep -w $pid | awk '{print $4}')

echo $port,$pid
echo -n "port: $port" >> $LOG_FILE

ps -eo pid,cmd,%mem,%cpu --sort=-%mem |  awk 'NR==4'>> $LOG_FILE