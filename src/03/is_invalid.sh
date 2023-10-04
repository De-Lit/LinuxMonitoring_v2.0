#!/bin/sh
IS_INVALID=0;
RED='\033[0;31m'
NC='\033[0m'
# Проверка параметра '2'(соответствует маске даты и времени)
if [[ !("$1" =~ ^[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}[[:space:]][[:digit:]]{2}:[[:digit:]]{2}$) ]];
then 
    echo "$3: $1: Invalid value"
    echo -e "usage: $3 2 [${RED}LATER LIST${NC}] [DATE]"
    echo -e "example: $3 2 [${RED}\"2022-10-26 22:51\"${NC}] [DATE]"
    IS_INVALID=1
fi
# Проверка параметра '3'(соответствует маске даты и времени)
if [[ !("$2" =~ ^[[:digit:]]{4}-[[:digit:]]{2}-[[:digit:]]{2}[[:space:]][[:digit:]]{2}:[[:digit:]]{2}$) ]];
then 
    echo "$3: $1: Invalid value"
    echo -e "usage: $3 2 [DATE] [${RED}LATER LIST${NC}]"
    echo -e "example: $3 2 [DATE] [${RED}\"2022-10-26 22:51\"${NC}]"
    IS_INVALID=1
fi
