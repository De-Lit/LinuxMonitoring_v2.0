#!/bin/sh
MY_PATH=/home/$whoami
# Запись директорий в массив
list=()
while read s; do
    list+=( "$s" )
done < <(find $MY_PATH -type d -newerct "$1" ! -newerct "$2")
# Проверка директории на существование > удаление
for item in ${list[*]}
do
    if [ -d $item ] && [[ "$item" =~ ^.*[[:alpha:]]{5,}_[[:digit:]]{6}$ ]];
    then
        ls -1R $item
        rm -rf $item
    fi
done
