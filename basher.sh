#!/bin/bash

#####################
# App Name : Basher #
#####################

#Define the minimum no. of arguments
MIN_ARGS=1
APP=`basename $0`

# Function to get the version of the script
# Make sure there is a file called VERSION with the 
# version information about the script
get_version () {
    FILE=VERSION
    k=1
    echo
    while read line;do
        echo "$line"
        ((k++))
    done < $FILE
    echo
}

# Put your command-line help here
usage () {
    echo -e "\n$APP : Boilerplate code to start writing bash scripts similar to most Linux command-line utilities"
    echo -e "Usage :"
    echo -e "\t$APP [-h|--help] [-v|--version] [-r|--required 123] [-o|--optional [124]]"
    echo -e "where,"
    echo -e "\t-r, --required <arg> : If this flag is set, an argument is mandatory"
    echo -e "\t-o, --option [arg] : If this flag is set, an argument is optional"
    echo -e "\t-v, --version : Show script version info"
    echo -e "\t-h, --help : Show this Help message"
}

# If the minimum specified options are not provided, we walk
if [[ $# < $MIN_ARGS ]];
then
    echo "Error : Too few arguments"
    usage
    exit 1
fi

OPTIONS=`getopt -o vho::r: --long version,help,optional::,required: -n '$APP' -- "$@"`
if [ $? != 0 ];
then
    echo "Error Parsing arguments"
    usage
    exit 1
fi

#echo $OPTIONS
#eval set -- "$OPTIONS"

#Set Variable defaults for the options to be parsed
HELP=false
VERSION=false
ARG_OPTIONAL=""
ARG_REQUIRED=""

while true; do
    case "$1" in
        -v | --version) VERSION=true; shift;;
        -h | --help) HELP=true; shift;;
        -o | --optional)
            case "$2" in
                "") ARG_OPTIONAL=666; shift; shift;;
                *) ARG_OPTIONAL=$2; shift; shift;;
            esac ;;
        -r | --required)
            case "$2" in
                "") echo "Argument Missing"; exit 1; break;;
                *) ARG_REQUIRED=$2; shift; shift;;
            esac
            ;;
        -- ) shift; break;;
        *)  break;;
    esac
done

if $HELP;
then
    usage
fi

if $VERSION;
then
    get_version
fi

if [ -z $ARG_OPTIONAL ];
then
    echo "Optional Argument not set" > /dev/null
else
    echo "Optional Argument is set as $ARG_OPTIONAL"
fi

if [ -z $ARG_REQUIRED ];
then
    echo "Required Argument not set" > /dev/null
else
    echo "Required Argument is set as $ARG_REQUIRED"
fi

exit 0

