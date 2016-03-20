#!/bin/bash
set -e

HOST="0.0.0.0"
PORT="8080"

while [[ $# > 1 ]]
do
key="$1"

case $key in
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

if [ -z ${LICENSE+x} ]; then echo "A license for AMP from cubecoders.com is required and must be specified as --license_key xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"; exit 1; fi
if [ -z ${USERNAME+x} ]; then echo "A username must be specified. eg --username amp_user"; exit 1; fi
if [ -z ${PASSWORD+x} ]; then echo "A password must be specified. eg --password P4$$w0Rd"; exit 1; fi

exec ./ampinstmgr CreateInstance ADS ADSInstance $HOST $PORT $LICENSE $PASSWORD +Core.Login.Username $USERNAME
exec ./ampinstmgr StartInstance ADSInstance
