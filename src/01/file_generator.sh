#!/bin/sh
DATE=$(date +"_%d%m%y")
LOG_PATH="../common/logs_01.log"
DIR_PATH=$1
if [ "${DIR_PATH: -1}" != '/' ];
then
    DIR_PATH=${DIR_PATH}'/'
fi
DIR_NUM=$2
DIR_NAME=$3
FILE_NUM=$4
FILE_NAME_FULL=$5
FILE_NAME=${FILE_NAME_FULL%.*}
FILE_NAME_EXTENTION=${FILE_NAME_FULL#*.}
FILE_SIZE=${6%*kb}
INDEX_DIR_NAME_LAST_SYMBOL=$((${#DIR_NAME}-1))
INDEX_FILE_NAME_LAST_SYMBOL=$((${#FILE_NAME}-1))
DIR_NAME_LAST_SYMBOL=${DIR_NAME:$INDEX_DIR_NAME_LAST_SYMBOL}
FILE_NAME_LAST_SYMBOL=${FILE_NAME:$INDEX_FILE_NAME_LAST_SYMBOL}
MIN_MEMORY_SIZE=1048576
FREE_MEMORY_SIZE=$(df -k / | awk '{printf "%d", $4}' | sed 's/^0*//')
while [ ${#DIR_NAME} -lt 4 ];
do
    DIR_NAME=${DIR_NAME}"$DIR_NAME_LAST_SYMBOL"
done
while [ ${#FILE_NAME} -lt 4 ];
do
    FILE_NAME=${FILE_NAME}"$FILE_NAME_LAST_SYMBOL"
done
while [[ "$DIR_NUM" -gt 0 ]] && [[ $FREE_MEMORY_SIZE -gt $MIN_MEMORY_SIZE ]];
do
    if [ -d $1 ];
    then
    rm -rf ${DIR_PATH}${DIR_NAME}_$DATE
    fi
    mkdir ${DIR_PATH}$DIR_NAME$DATE
    echo "dir: ${DIR_PATH}$DIR_NAME$DATE $(date +"%d.%m.%Y")" >> $LOG_PATH
    FILE_NAME_TMP=$FILE_NAME
    FILE_NUM_TMP=$FILE_NUM
    while [[ "$FILE_NUM_TMP" -gt 0 ]] && [[ $FREE_MEMORY_SIZE -gt $MIN_MEMORY_SIZE ]];
    do
        fallocate -l ${FILE_SIZE}KB $DIR_PATH$DIR_NAME$DATE/${FILE_NAME_TMP}$DATE.$FILE_NAME_EXTENTION
        if [ -f $DIR_PATH$DIR_NAME$DATE/${FILE_NAME_TMP}$DATE.$FILE_NAME_EXTENTION ];
        then
            echo "file: $DIR_PATH$DIR_NAME$DATE/$FILE_NAME_TMP$DATE.$FILE_NAME_EXTENTION $(date +"%d.%m.%Y") $6" >> $LOG_PATH
        fi
        FREE_MEMORY_SIZE=$(df -k / | awk '{printf "%d", $4}' | sed 's/^0*//')
        FILE_NAME_TMP=$FILE_NAME_TMP"$FILE_NAME_LAST_SYMBOL"
        FILE_NUM_TMP=$((${FILE_NUM_TMP} - 1))
    done
    DIR_NAME=$DIR_NAME"$DIR_NAME_LAST_SYMBOL"
    DIR_NUM=$((${DIR_NUM} - 1))
done
