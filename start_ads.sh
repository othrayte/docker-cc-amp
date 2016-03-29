#!/bin/bash
set -e

HOST="0.0.0.0"
PORT="8080"
MODULE="ADS"
INSTANCE_NAME="Instance"

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -n|--instance-name)
    INSTANCE_NAME="$2"
    shift # past argument
    ;;
    -m|--module)
    MODULE="$2"
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
    *)
            # unknown option
    ;;
esac
shift # past argument or value
done

if [ -z ${LICENCE+x} ]; then echo "A licence for AMP from cubecoders.com is required and must be specified as --licence_key xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"; exit 1; fi

if [ ! -d ~/.ampdata/instances/$INSTANCE_NAME/ ]; then
    if [ -z ${USERNAME+x} ]; then echo "A username must be specified. eg --username amp_user"; exit 1; fi
    if [ -z ${PASSWORD+x} ]; then echo "A password must be specified. eg --password P4$$w0Rd"; exit 1; fi
    ./ampinstmgr CreateInstance $MODULE $INSTANCE_NAME $HOST $PORT $LICENCE $PASSWORD +Core.Login.Username $USERNAME
    (cd /ampdata/instances/$INSTANCE_NAME && exec ./AMP_Linux_x86_64)
else
    (cd /ampdata/instances/$INSTANCE_NAME && ./AMP_Linux_x86_64 +Core.AMP.LicenceKey $LICENCE && exec ./AMP_Linux_x86_64)
fi
