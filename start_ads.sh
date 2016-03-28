#!/bin/bash
set -e

HOST="0.0.0.0"
PORT="8080"
MODULE="ADS"

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -m|--module)
    MODULE="$2"
    shift # past argument
    ;;
    -l|--license-key)
    LICENSE="$2"
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

if [ ! -d ~/.ampdata/instances/Instance/ ]; then
    if [ -z ${LICENSE+x} ]; then echo "A license for AMP from cubecoders.com is required and must be specified as --license_key xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"; exit 1; fi
    if [ -z ${USERNAME+x} ]; then echo "A username must be specified. eg --username amp_user"; exit 1; fi
    if [ -z ${PASSWORD+x} ]; then echo "A password must be specified. eg --password P4$$w0Rd"; exit 1; fi
    ./ampinstmgr CreateInstance $MODULE Instance $HOST $PORT $LICENSE $PASSWORD +Core.Login.Username $USERNAME
fi
./ampinstmgr StartInstance Instance

# Wait for all AMP processes to finish
sleep 2; while [ -e /proc/$(pgrep -o AMP) ]; do sleep 5; done
