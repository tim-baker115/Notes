#!/bin/bash

if [ x$1 == x ] || [ x$2 == x ] ; then
        echo USAGE: $0 stream_file_name dest_ip_address
        exit 1
fi
if [ ! -e $1 ] ; then
        echo STREAM FILE $1 NOT FOUND
        exit 1
fi

cvlc --repeat $1 --sout="#std{access=udp,mux=ts,dst=$2:1234}" --sout-keep