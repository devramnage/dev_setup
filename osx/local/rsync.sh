#!/opt/local/bin/bash
set -x

pushd "${0%/*}"

#USER_NAME="uidev"
#PATH_TO_SRC="/home/uidev/qt_proj/qt/"
USER_NAME="rokudev"
PATH_TO_SRC="/home/rokudev/phoenix_rsync/"
VIRTUAL_MACHINE_IP=$(<VM_IP.txt)
#VIRTUAL_MACHINE_IP=$(<VM_IP_HOME.txt)
while (( "$#" )); do
    case "$1" in
        -ip=*)
            VIRTUAL_MACHINE_IP="${1:4}"
            ;;
    esac
    shift
done

rsync -v -a -e ssh ../../phoenix/tools ${USER_NAME}@${VIRTUAL_MACHINE_IP}:${PATH_TO_SRC}
rsync -v -a -e ssh ../../phoenix/app/libs/airbag* ${USER_NAME}@${VIRTUAL_MACHINE_IP}:${PATH_TO_SRC}/app/libs
rsync -v -a -e ssh ../../phoenix/app/libs/roku ${USER_NAME}@${VIRTUAL_MACHINE_IP}:${PATH_TO_SRC}/app/libs
rsync -v -a -e ssh ../../phoenix/app/packaging ${USER_NAME}@${VIRTUAL_MACHINE_IP}:${PATH_TO_SRC}/app
rsync -v -a -e ssh ../../phoenix/app/src ${USER_NAME}@${VIRTUAL_MACHINE_IP}:${PATH_TO_SRC}/app
rsync -v -a -e ssh ../../phoenix/watchdog ${USER_NAME}@${VIRTUAL_MACHINE_IP}:${PATH_TO_SRC}
rsync -v -a -e ssh ../../phoenix/phoenix_subdirs.pro ${USER_NAME}@${VIRTUAL_MACHINE_IP}:${PATH_TO_SRC}
#rsync -v -a -e ssh ../../phoenix/build ${USER_NAME}@${VIRTUAL_MACHINE_IP}:${PATH_TO_SRC}

popd
set +x
