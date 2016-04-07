#!/bin/bash

if [ x$1 == x ] ; then
        echo USAGE: $0 stream_file_name
        exit 1
fi
if [ ! -e $1 ] ; then
        echo STREAM FILE $1 NOT FOUND
        exit 1
fi

cvlc -vvv $1 --sout="#standard{access=http,dst=:8080/sintel,mux=ts}" --sout-keep