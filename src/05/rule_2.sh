#!/bin/sh
echo "$(find ../common/ -type f -regextype sed -regex '.*log_file_[[:digit:]]*$' -print0 |
        sort -unk1 --files0-from=- |
        awk '{ print $1 }' )"
