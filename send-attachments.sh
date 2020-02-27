#!/bin/bash

set -x

do_send() {
    set -x
    name=$(basename "$1")
    echo -e "to: ${TARGET_MAIL}\nsubject: ${name}\n"| (cat - && uuencode "$1" "${name}") | ssmtp -f${FROM_MAIL} ${TARGET_MAIL}
    if [ $? -ne 0 ]; then
        echo "error while sending $1"
        return
    fi
    rm $1
    echo "successfully sent $1"
}

export -f do_send

echo "start ooking for pdfs now"

while [ true ]; do
  sleep 15

  find /input/ -iname "${INAME_FILTER}" -type f -exec bash -c 'do_send "$0"' {} \;
done
