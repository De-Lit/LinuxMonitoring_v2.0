#!/bin/sh
function get_remote_addr {
    num_1=$RANDOM && let "num_1 %= 255"
    num_2=$RANDOM && let "num_2 %= 255"
    num_3=$RANDOM && let "num_3 %= 255"
    num_4=$RANDOM && let "num_4 %= 255"
    echo "$num_1.$num_2.$num_3.$num_4"
}
function get_random_item_from_arrey {
    declare -a argAry=("${!1}")
    RANGE=${#argAry[@]}
    number=$RANDOM
    let "number %= RANGE"
    echo ${argAry[number]}
}
response_codes=(
    # 2xx: Success (успешно)
    "200" # 200 OK («хорошо»)
    "201" # 201 Created («создано»)

    # 4xx: Client Error (ошибка клиента)
    "400" # 400 Bad Request («неправильный, некорректный запрос»)
    "401" # 401 Unauthorized («не авторизован (не представился)»)
    "403" # 403 Forbidden («запрещено (не уполномочен)»)
    "404" # 404 Not Found («не найдено»)

    # 5xx: Server Error (ошибка сервера)
    "500" # 500 Internal Server Error («внутренняя ошибка сервера»
    "501" # 501 Not Implemented («не реализовано»)
    "502" # 502 Bad Gateway («плохой, ошибочный шлюз»)
    "503" # 503 Service Unavailable («сервис недоступен»)
)
methods=(
    "GET" "POST" "PUT" "PATCH" "DELETE"
)
agents=(
    "Mozilla" "Google" "Chrome" "Opera" "Safari" "Internet Explorer" "Microsoft Edge" "Crawler and bot""Library and net tool"
)
function get_time {
    HOURS=$RANDOM
    let "HOURS %= 24"
    HOURS=$(printf "%02d" $HOURS)

    MINUTES=$RANDOM
    let "MINUTES %= 60"
    MINUTES=$(printf "%02d" $MINUTES)

    SECONDs=$RANDOM
    let "SECONDs %= 60"
    SECONDs=$(printf "%02d" $SECONDs)

    echo "$HOURS:$MINUTES:$SECONDs"
}
function get_date {
    echo "$(date +"%d/%b/%Y" -d "$1 day ago")"
}
function get_time_local {
    DATE=$(get_date $1)
    TIME=$(get_time)
    echo "$DATE:$TIME $(date +"%z")"
}
function get_status {
    STATUS=$(get_random_item_from_arrey response_codes[@])
    echo "$STATUS"
}
function get_bytes_sent {
    BYTES_SENT=$RANDOM
    let "BYTES_SENT %= 50000"
    echo "$BYTES_SENT"
}
function get_URL {
    while
        COUNT=$RANDOM
        let "COUNT %= 30"
        [[ "$COUNT" -lt 20 ]]
    do false; done
    STRING=$(echo $RANDOM | md5sum | head -c $COUNT;)
    echo "/$STRING HTTP/1.1"
}
function get_request {
    echo "$(get_random_item_from_arrey methods[@]) $(get_URL)"
}
function get_log {
    remote_addr=$(get_remote_addr)
    remote_user="-"
    time_local=$(get_time_local $1)
    request=$(get_request)
    status=$(get_status)
    bytes_sent=$(get_bytes_sent)
    http_referer="-"
    http_user_agent=$(get_random_item_from_arrey agents[@])
    echo "$remote_addr - $remote_user [$time_local] \"$request\" $status $bytes_sent \"$http_referer\" \"$http_user_agent\""
}
function make_log_file {
    > ../common/log_file_$1
    while
        COUNT=$RANDOM
        let "COUNT %= 1001"
        [[ "$COUNT" -le 100 ]]
    do false; done
    while [[ "$COUNT" -gt 0 ]]
    do
        echo "$(get_log $1)" >> ../common/log_file_$1
        $(sort -t":" -nk2 -nk3 -nk4 -o ../common/log_file_$1 ../common/log_file_$1)
        COUNT=$((${COUNT} - 1))
    done
}
function main {
    COUNT=1
    while [[ "$COUNT" -le 5 ]]
    do
        $(make_log_file $COUNT)
        COUNT=$((${COUNT} + 1))
    done
}
if [ "$#" -eq 0 ];
then
    $(main)
else
    echo "$0: Incorrect number of parameters"
    echo "usage: $0"
    exit 1
fi
