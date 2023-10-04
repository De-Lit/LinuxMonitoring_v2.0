#!/bin/sh
function add_symbol_to_dir_name {
    DIR_NAME=$1
    INDEX_DIR_NAME_LAST_SYMBOL=$((${#DIR_NAME}-1))
    DIR_NAME_LAST_SYMBOL=${DIR_NAME:$INDEX_DIR_NAME_LAST_SYMBOL}
    echo ${DIR_NAME}"$DIR_NAME_LAST_SYMBOL"
}
function make_correct_dir_name {
    DIR_NAME=$1
    while [ ${#DIR_NAME} -lt 5 ];
    do
        DIR_NAME=$(add_symbol_to_dir_name $DIR_NAME)
    done
    echo $DIR_NAME
}
function make_correct_file_name {
    FILE_NAME_FULL=$1
    FILE_NAME=${FILE_NAME_FULL%.*}
    FILE_NAME_EXTENTION=${FILE_NAME_FULL#*.}
    INDEX_FILE_NAME_LAST_SYMBOL=$((${#FILE_NAME}-1))
    FILE_NAME_LAST_SYMBOL=${FILE_NAME:$INDEX_FILE_NAME_LAST_SYMBOL}
    while [ ${#FILE_NAME} -lt 5 ];
    do
        FILE_NAME=${FILE_NAME}"$FILE_NAME_LAST_SYMBOL"
    done
    echo $FILE_NAME.$FILE_NAME_EXTENTION
}
function generate_dir {
    MY_PATH=$1
    list=($(find $MY_PATH -type d -not -wholename "*/bin*" -not -wholename "*/sbin*"))
    RANGE=${#list[@]}
    let "RANGE -= 1"
    number=$RANDOM
    let "number %= RANGE"
    echo ${list[number]}
}
function generate_files_in_dir {
    DIR_NAME=$(make_correct_dir_name $1)
    FILE_NAME=$(make_correct_file_name $2)
    FILE_SIZE=$3
    DATE=$(date +"_%d%m%y")
    while
        MY_PATH=$(generate_dir /home/$(whoami))
        [[  $(find $MY_PATH -maxdepth 0 -type d -print | wc -l) -ge 100  ]]
    do true; done
    while
        [[  -d $MY_PATH/$DIR_NAME$DATE  ]];
    do 
        DIR_NAME=$(add_symbol_to_dir_name $DIR_NAME);
    done
    mkdir $MY_PATH/$DIR_NAME$DATE
    echo "dir: $MY_PATH/$DIR_NAME$DATE $(date +"%d.%m.%Y")" >> ../common/logs_02.log
    let "FILE_NUM=$RANDOM % 7"
    SIGN=$(bash file_generator.sh $FILE_NUM $FILE_NAME $FILE_SIZE $MY_PATH/$DIR_NAME$DATE)
    return $SIGN
}
while
    generate_files_in_dir $1 $2 $3
    [[  $? -eq 0  ]]
do true; done
