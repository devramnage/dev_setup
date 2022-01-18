set -x

pushd "${0%/*}"

USER_NAME="rokudev"
VIRTUAL_MACHINE_IP=$(<VM_IP.txt)
ROKU_IP=10.124.27.70
BUILD_ROKU=true
BUILD_DESKTOP=false
RUN_TELNET=false


while (( "$#" )); do
    case "$1" in
        -r | -R)
            BUILD_ROKU=true
            ;;
        -t | -T)
            RUN_TELNET=true
            ;;
        telnet_only)
            RUN_TELNET=true
            BUILD_DESKTOP=false
            BUILD_ROKU=false
            ;;
        -d | -D)
            BUILD_DESKTOP=true
            ;;
        -desktop_only | -do)
            BUILD_DESKTOP=true
            BUILD_ROKU=false
            ;;
        -ip=*)
            ROKU_IP="${1:4}"
            ;;
        -h)
            VIRTUAL_MACHINE_IP=$(<VM_IP_HOME.txt)
            ROKU_IP=192.168.1.143
            ;;
    esac
    shift
done

if $BUILD_ROKU; then
    ROKU_IP_FLAG="-ip=${ROKU_IP}"

    ../local/rsync.sh -ip=${VIRTUAL_MACHINE_IP}

    printf -v _ %q "%1"
    ssh ${USER_NAME}@${VIRTUAL_MACHINE_IP}  "./phoenix_rsync/local/load.sh ${ROKU_IP_FLAG}"
fi

if $BUILD_DESKTOP; then
    ../local/make.sh && ../local/start.sh
fi

if $RUN_TELNET; then
    telnet ${ROKU_IP} 8085
fi


popd
set +x
