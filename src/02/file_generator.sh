#!/bin/sh
DATE=$(date +"_%d%m%y")
FILE_NUM=$1
FILE_NAME_FULL=$2
FILE_NAME=${FILE_NAME_FULL%.*}
FILE_NAME_EXTENTION=${FILE_NAME_FULL#*.}
FILE_SIZE=${3%*Mb}
FILE_PATH=$4
INDEX_FILE_NAME_LAST_SYMBOL=$((${#FILE_NAME}-1))
FILE_NAME_LAST_SYMBOL=${FILE_NAME:$INDEX_FILE_NAME_LAST_SYMBOL}
MIN_MEMORY_SIZE=1000
FREE_MEMORY_SIZE=$(df -h -BM / | awk '{printf "%d", $4}' | sed 's/^0*//')
while [[ "$FILE_NUM" -gt 0 ]] && [[ "$FREE_MEMORY_SIZE - $FILE_SIZE" -gt "$MIN_MEMORY_SIZE" ]];
do
    fallocate -l ${FILE_SIZE}MB $FILE_PATH/${FILE_NAME}$DATE.$FILE_NAME_EXTENTION
    if [ -f $FILE_PATH/${FILE_NAME}$DATE.$FILE_NAME_EXTENTION ];
    then
        echo "file: ${FILE_PATH}/${FILE_NAME}$DATE.$FILE_NAME_EXTENTION $(date +"%d.%m.%Y") $3" >> ../common/logs_02.log
    fi
    FREE_MEMORY_SIZE=$(df -h -BM / | awk '{printf "%d", $4}' | sed 's/^0*//')
    FILE_NAME=$FILE_NAME"$FILE_NAME_LAST_SYMBOL"
    FILE_NUM=$((${FILE_NUM} - 1))
done
SIGN=0
if ! [[ "$FREE_MEMORY_SIZE - $FILE_SIZE" -gt "$MIN_MEMORY_SIZE" ]];
then
    SIGN=1
fi
echo $SIGN
