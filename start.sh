#!/bin/bash
set -e

if [[ $# -eq 0 ]]; then
    # No arguments, they must all be passed as env vars
    echo "Info: No direct arguments detected, expecting MODULE and LICENCE environment variables."
    if [ -z ${MODULE+x} ]; then echo "Error: The module name must be specified in the MODULE enviroment variable"; exit 1; fi
    if [ -z ${LICENCE+x} ]; then echo "Error: A licence for AMP from cubecoders.com is required and must be specified in the LICENCE environment variable"; exit 1; fi
else
    if [[ $1 == -- ]]; then
        shift
        exec "$@"
    fi
    
    if [[ $1 != [a-zA-Z]* ]]; then
        exec "$@"
    fi
    
    # First argument must be the module name
    MODULE="$1"
    shift
fi

HOST=${HOST:-"0.0.0.0"}
PORT=${PORT:-"8080"}
USERNAME=${USERNAME:-"admin"}
PASSWORD=${PASSWORD:-"password"}
INSTANCE_NAME=${INSTANCE_NAME:-"Instance"}

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -n|--instance-name)
    INSTANCE_NAME="$2"
    shift # past argument
    ;;
    -l|--licence-key)
    LICENCE="$2"
    shift # past argument
    ;;
    -p|--password)
    PASSWORD="$2"
    shift # past argument
    ;;
    -u|--username)
    USERNAME="$2"
    shift # past argument
    ;;
    -h|--host)
    HOST="$2"
    shift # past argument
    ;;
    --port)
    PORT="$2"
    shift # past argument
    ;;
    +*)
    EXTRAS+=("$1" "$2")
    shift # past argument
    ;;
    *)
    echo "Unknown option $1"
    exit 1
    ;;
esac
shift # past argument or value
done

if [ -z ${LICENCE+x} ]; then echo "Error: A licence for AMP from cubecoders.com is required and must be specified as --licence_key xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"; exit 1; fi

echo "Info: Downloading ampinstmgr to get the latest nightly build."
cd /home/AMP/AMP && \
wget http://cubecoders.com/Downloads/ampinstmgr_Nightly.zip && \
unzip ampinstmgr_Nightly.zip && \
rm -fi --interactive=never ampinstmgr_Nightly.zip

if [ ! -d ~/.ampdata/instances/$INSTANCE_NAME/ ]; then
    echo "Creating module instance: ./ampinstmgr CreateInstance $MODULE $INSTANCE_NAME $HOST $PORT $LICENCE $PASSWORD +Core.Login.Username $USERNAME ${EXTRAS[@]}"
    ./ampinstmgr --nightly CreateInstance $MODULE $INSTANCE_NAME $HOST $PORT $LICENCE $PASSWORD +Core.Login.Username $USERNAME ${EXTRAS[@]}
    echo "Starting instance: $INSTANCE_NAME"
    (cd /ampdata/instances/$INSTANCE_NAME && exec ./AMP_Linux_x86_64)
else
    echo "Info: Upgrading the instand to the lastest nightly of AMP."
    ./ampinstmgr --nightly upgrade $INSTANCE_NAME
    echo "Starting instance: $INSTANCE_NAME"
    (cd /ampdata/instances/$INSTANCE_NAME && ./AMP_Linux_x86_64 +Core.AMP.LicenceKey $LICENCE && exec ./AMP_Linux_x86_64)
fi
