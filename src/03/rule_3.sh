#!/bin/sh
MY_PATH=/home/$whoami
# Запись директорий в массив
list=()
while read s; do
    list+=( "$s" )
done < <(find $MY_PATH -type d -regextype sed -regex '.*[[:alpha:]]\{5,\}_[[:digit:]]\{6\}$')
# Проверка директории на существование > удаление
for item in ${list[*]}
do
    if [ -d $item ];
    then
        ls -1R $item
        rm -rf $item
    fi
done
