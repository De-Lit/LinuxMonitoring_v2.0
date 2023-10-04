#!/bin/sh
echo "$(find ../common/ -type f -regextype sed -regex '.*log_file_[[:digit:]]*$' -print0 | 
        sort -m --files0-from=- |
        awk '{ if ( ($9 >= 400 && $9 <= 499) || ($9 >= 500 && $9 <= 599) ) print $1 }' |
        sort -u)"
