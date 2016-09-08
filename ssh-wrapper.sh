#!/bin/bash

if ! [ -z ${SSH_PASS+x} ]; then 
   echo 'www-data:'$SSH_PASS
   echo 'www-data:'$SSH_PASS | chpasswd
fi

/usr/sbin/sshd -D
