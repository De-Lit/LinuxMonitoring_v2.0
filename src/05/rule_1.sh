#!/bin/sh
echo "$(find ../common/ -type f -regextype sed -regex '.*log_file_[[:digit:]]*$' -print0 |
        sort -nk9 --files0-from=-)"
