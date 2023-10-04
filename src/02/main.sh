#!/bin/sh
START_TIME=$(date +%s)
START=$(date)
DIR_NAME=$1
FILE_NAME_FULL=$2
FILE_SIZE=$3

# Проверка на количество входных параметров
if [ "$#" -ne 3 ];
then
    echo "$0: Incorrect number of parameters"
    echo "usage: $0 [LATER LIST] [LATER LIST] [FILE SIZE]"
    exit 1
fi

source is_invalid.sh $DIR_NAME $FILE_NAME_FULL $FILE_SIZE $0
if [ "$IS_INVALID" == 0 ];
then
    bash trash_maker.sh $DIR_NAME $FILE_NAME_FULL $FILE_SIZE
else
    exit $IS_INVALID
fi

END_TIME=$(date +%s)
END=$(date)
TIME_ALL=$(($END_TIME - $START_TIME))
LOG_FILE=$(
    echo "start time: $START" 
    echo "end time: $END"
    echo "total time: $TIME_ALL"
)
echo "$LOG_FILE"
echo "$LOG_FILE" >> ../common/logs_02.log
echo "" >> ../common/logs_02.log
