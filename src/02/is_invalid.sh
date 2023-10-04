#!/bin/sh
IS_INVALID=0;
RED='\033[0;31m'
NC='\033[0m'
# Проверка параметра '1'(состоит из символов алфавита)
if [[ "$1" =~ [^[:alpha:]] ]];
then
    echo "$4: $1: Invalid value"
    echo -e "usage: $4 [${RED}LATER LIST${NC}] [FILE NAME] [FILE SIZE]"
    IS_INVALID=1
# Проверка параметра '1'(состоит из 1-7 символов)
elif [[ !("$1" =~ ^[[:alpha:]]{1,7}$) ]];
then
    echo "$4: $1: Invalid number of symbols"
    echo -e "usage: $4 [${RED}{1,7}${NC}] [FILE NAME] [FILE SIZE]"
    IS_INVALID=1
fi
# Проверка параметра '2'(состоит из символов алфавита)
if [[ "$2" =~ [^[:alpha:](\.)[:alpha:]] ]];
then
    echo "$4: $2: Invalid value"
    echo -e "usage: $4 [DIR NAME] [${RED}[:alpha:].[:alpha:]${NC}] [FILE SIZE]"
    IS_INVALID=1
# Проверка параметра '2'(состоит из 1-7(имя) и 1-3(расширение) символов)
elif [[ !("$2" =~ ^[[:alpha:]]{1,7}(\.)[[:alpha:]]{1,3}$) ]];
then
    echo "$4: $2: Invalid number of symbols"
    echo -e "usage: $4 [DIR NAME] [${RED}{1,7}.{1,3}${NC}] [FILE SIZE]"
    IS_INVALID=1
fi
# Проверка параметра '3'(положительное число не больше 100)
if [[ !("$3" =~ ^[0-9]*Mb$) ]];
then
    echo -e "$4: $3: Invalid value"
    echo -e "usage: $4 [DIR NAME] [FILE NAME] [${RED}FILE SIZE${NC}]"
    IS_INVALID=1
elif [[ ${3%*Mb} -gt 100 ]] || [[ ${3%*Mb} -lt 0 ]]
then
    echo -e "$4: $3: Invalid file size"
    echo -e "usage: $4 [DIR NAME] [FILE NAME] [${RED}0Mb <= FILE SIZE <= 100Mb${NC}]"
    IS_INVALID=1
fi
