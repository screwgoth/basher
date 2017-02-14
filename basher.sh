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
    cat VERSION
}

# Put your command-line help here
usage () {
    get_version
    echo -e "\n\033[34m$APP : Boilerplate code to start writing bash scripts similar to most Linux command-line utilities"
    echo -e "\033[34mUsage :"
    echo -e "\t\033[34m$APP [-h|--help] [-v|--version] [-r|--required 123] [-o|--optional [124]]\033[0m"
    echo -e "\t\033[34m$APP -r|--required <argument>"
    echo -e "\t\033[34m$APP -o|--optional [optional_argument]"
    echo -e "\033[34mwhere,"
    echo -e "\t\033[34m-r, --required <arg> : If this flag is set, an argument is mandatory"
    echo -e "\t\033[34m-o, --option [arg] : If this flag is set, an argument is optional"
    echo -e "\t\033[34m-v, --version : Show script version info"
    echo -e "\t\033[34m-h, --help : Show this Help message\033[0m"
}

# If the minimum specified options are not provided, we walk
if [[ $# < $MIN_ARGS ]];
then
    echo -e "\033[31mError : Too few arguments\033[0m"
    usage
    exit 1
fi

OPTIONS=`getopt -o vho::r: --long version,help,optional::,required: -n '$APP' -- "$@"`
if [ $? != 0 ];
then
    echo -e "\033[31mError Parsing arguments\033[0m"
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
        -v | --version)
            VERSION=true
            break;;
        -h | --help)
            HELP=true
            break;;
        -o | --optional)
            case "$2" in
                "")
                    ARG_OPTIONAL=666
                    shift
                    shift;;
                *)
                    ARG_OPTIONAL=$2
                    shift
                    shift;;
            esac ;;
        -r | --required)
            case "$2" in
                "")
                    echo -e "\033[31mArgument Missing. It is mandatory to provide an argument for this flag\033[0m"
                    exit 1
                    break;;
                *)
                    ARG_REQUIRED=$2
                    shift
                    shift;;
            esac
            ;;
        --)
            shift
            break;;
        *)
            break;;
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
    echo -e "\033[32mOptional Argument is set as $ARG_OPTIONAL\033[0m"
fi

if [ -z $ARG_REQUIRED ];
then
    echo "Required Argument not set" > /dev/null
else
    echo -e "\033[32mRequired Argument is set as $ARG_REQUIRED\033[0m"
fi

exit 0
