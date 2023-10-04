#!/bin/sh
IS_INVALID=0;
RED='\033[0;31m'
NC='\033[0m'
# Проверка параметра '1' (существование директории)
if ! [ -d $1 ];
then
    echo "$7: No directory '$1'"
    IS_INVALID=1
fi
# Проверка параметра '2' (целочисленный, неотрицательный)
if [[ $2 = *[^0-9]* ]];
then
    echo "$7: $2: Is not an unsigned integer"
    echo -e "usage: $7 [PATH] [${RED}NUMBER OF DIRECTORIES${NC}] [LATER LIST] [NUMBER OF FILES IN DIRECTORY] [LATER LIST] [FILE SIZE]"
    IS_INVALID=1
fi
# Проверка параметра '3'(состоит из символов алфавита)
if [[ "$3" =~ [^[:alpha:]] ]];
then
    echo "$7: $3: Invalid value"
    echo -e "usage: $7 [PATH] [NUMBER OF DIRECTORIES] [${RED}LATER LIST${NC}] [NUMBER OF FILES IN DIRECTORY] [LATER LIST] [FILE SIZE]"
    IS_INVALID=1
# Проверка параметра '3'(состоит из 1-7 символов)
elif [[ !("$3" =~ ^[[:alpha:]]{1,7}$) ]];
then
    echo "$7: $3: Invalid number of symbols"
    echo -e "usage: $7 [PATH] [NUMBER OF DIRECTORIES] [${RED}{1,7}${NC}] [NUMBER OF FILES IN DIRECTORY] [LATER LIST] [FILE SIZE]"
    IS_INVALID=1
fi
# Проверка параметра '4' (целочисленный, неотрицательный)
if [[ $4 = *[^0-9]* ]];
then
    echo "$7: $4: Is not an unsigned integer"
    echo -e "usage: $7 [PATH] [NUMBER OF DIRECTORIES] [LATER LIST] [${RED}NUMBER OF FILES IN DIRECTORY${NC}] [LATER LIST] [FILE SIZE]"
    IS_INVALID=1
fi
# Проверка параметра '5'(состоит из символов алфавита)
if [[ "$5" =~ [^[:alpha:](\.)[:alpha:]] ]];
then
    echo "$7: $5: Invalid value"
    echo -e "usage: $7 [PATH] [NUMBER OF DIRECTORIES] [LATER LIST] [NUMBER OF FILES IN DIRECTORY] [${RED}[:alpha:].[:alpha:]${NC}] [FILE SIZE]"
    IS_INVALID=1
# Проверка параметра '5'(состоит из 1-7(имя) и 1-3(расширение) символов)
elif [[ !("$5" =~ ^[[:alpha:]]{1,7}(\.)[[:alpha:]]{1,3}$) ]];
then
    echo "$7: $5: Invalid number of symbols"
    echo -e "usage: $7 [PATH] [NUMBER OF DIRECTORIES] [LATER LIST] [NUMBER OF FILES IN DIRECTORY] [${RED}{1,7}.{1,3}${NC}] [FILE SIZE]"
    IS_INVALID=1
fi
# Проверка параметра '6'(положительное число не больше 100)
if [[ !("$6" =~ ^[0-9]*kb$) ]];
then
    echo -e "$7: $6: Invalid value"
    echo -e "usage: $7 [PATH] [NUMBER OF DIRECTORIES] [LATER LIST] [NUMBER OF FILES IN DIRECTORY] [LATER LIST] [${RED}FILE SIZE${NC}]"
    IS_INVALID=1
elif [[ ${6%*kb} -gt 100 ]] || [[ ${6%*kb} -lt 0 ]]
then
    echo -e "$7: $6: Invalid file size"
    echo -e "usage: $7 [PATH] [NUMBER OF DIRECTORIES] [LATER LIST] [NUMBER OF FILES IN DIRECTORY] [LATER LIST] [${RED}0kb <= FILE SIZE <= 100kb${NC}]"
    IS_INVALID=1
fi
