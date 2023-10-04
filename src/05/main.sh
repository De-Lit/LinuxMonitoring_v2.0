#!/bin/sh
ERROR=$(echo "$0: Incorrect parameter"
        echo "usage: $0 1 - All entries sorted by response code"
        echo "usage: $0 2 - All unique IPs found in records"
        echo "usage: $0 3 - All requests with errors (response code - 4xx or 5xx)"
        echo "usage: $0 4 - All unique IPs that occur among failed requests")
if [ "$#" -eq 1 ] && [[ "$1" -ge 1 ]] && [[ "$1" -le 4 ]];
then
    if [[ "$1" -eq 1 ]]
    then
        bash rule_1.sh
    else
    if [[ "$1" -eq 2 ]]
    then
        bash rule_2.sh
    else
    if [[ "$1" -eq 3 ]]
    then
        bash rule_3.sh
    else
    if [[ "$1" -eq 4 ]]
    then
        bash rule_4.sh
    fi
    fi
    fi
    fi
else
    echo "$ERROR"
    exit 1
fi
