#!/bin/bash

if [ -f /var/log/send-attachments.log ]; then
    touch /var/log/send-attachments.log
fi

# update CA certificates if necessary from /config/*.crt
if stat --printf='' /config/*.crt 2>/dev/null
then
    cp -v /config/*.crt /usr/local/share/ca-certificates/
    update-ca-certificates
fi

/opt/send-attachments.sh
