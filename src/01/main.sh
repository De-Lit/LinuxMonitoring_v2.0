#!/bin/sh
DIR_PATH=$1
DIR_NUM=$2
DIR_NAME=$3
FILE_NUM=$4
FILE_NAME_FULL=$5
FILE_SIZE=$6

# Проверка на количество входных параметров
if [ "$#" -ne 6 ];
then
    echo "$0: Incorrect number of parameters"
    echo "usage: $0 [PATH] [NUMBER OF DIRECTORIES] [LATER LIST] [NUMBER OF FILES IN DIRECTORY] [LATER LIST] [FILE SIZE]"
    exit 1
fi

source is_invalid.sh $DIR_PATH $DIR_NUM $DIR_NAME $FILE_NUM $FILE_NAME_FULL $FILE_SIZE $0
if [ "$IS_INVALID" == 0 ];
then
    bash file_generator.sh $DIR_PATH $DIR_NUM $DIR_NAME $FILE_NUM $FILE_NAME_FULL $FILE_SIZE
else
    exit $IS_INVALID
fi
