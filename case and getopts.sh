#!/bin/bash
    
    function check_variables (){
            #Check whether variables have been assigned or not, exit it they're not assigned.
            if [ -z $VARIABLE1 ]; then
                    echo "-H) The -H variable has not been set."
                    exit 1
            fi
            if [ -z $VARIABLE2 ]; then
                    echo "-e) The -e variable has not been set."
                    exit 2
            fi
            if [ -z $VARIABLE3 ]; then
                    echo "-l) The -l variable has not been set."
                    exit 3
            fi
            if [ -z $VARIABLE4 ]; then
                    echo "-p) The -p variable has not been set."
                    exit 4
            fi
            echo "Got to the end with all variables assigned! Content is as follows:"
            echo "VARIABLE1 set to $VARIABLE1"
            echo "VARIABLE2 set to $VARIABLE2"
            echo "VARIABLE3 set to $VARIABLE3"
            echo "VARIABLE4 set to $VARIABLE4"
    }
    
    while getopts ":H:e:l:p:" o; do
            case "${o}" in
                    H)
                            VARIABLE1=${OPTARG}
                            ;;
                    e)
                            VARIABLE2=${OPTARG}
                            ;;
                    l)
                            VARIABLE3=${OPTARG}
                            ;;
                    p)
                            VARIABLE4=${OPTARG}
                            ;;
                    *)
                            check_variables
                            ;;
    
            esac
    done
    
    shift $((OPTIND-1))
    
    check_variables