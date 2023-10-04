#!/bin/sh
LOG_PATH=../common/logs_02.log
# Запись директорий в массив
list=()
while read s; do
    list+=( "$s" )
done < <(grep -e "dir:" $LOG_PATH | awk '{printf "%s\n", $2}')
# Проверка директории на существование > удаление
for item in ${list[*]}
do
    if [ -d $item ];
    then
        ls -1R $item
        rm -rf $item
    fi
done
