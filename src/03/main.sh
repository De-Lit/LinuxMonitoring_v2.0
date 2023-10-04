#!/bin/sh
ERROR=$(echo "$0: Incorrect parameters"
        echo "usage: $0 1 - LOG FILE"
        echo "usage: $0 2 "[DATE]" "[DATE]" - BORN TIME"
        echo "usage: $0 3 - NAME MASK")
if [ "$#" -eq 1 ];
then
    if [[ "$1" -eq 1 ]];
    then
        bash rule_1.sh
    else
    if [[ "$1" -eq 3 ]];
    then
        bash rule_3.sh
    else
        echo "$ERROR"
        exit 1
    fi
    fi
else
if [ "$#" -eq 3 ] && [ "$1" -eq 2 ];
then
    source is_invalid.sh "$2" "$3" $0
    if [ "$IS_INVALID" == 0 ];
    then
        bash rule_2.sh "$2" "$3"
    else
        exit $IS_INVALID
    fi
else
    echo "$ERROR"
    exit 1
fi
fi
