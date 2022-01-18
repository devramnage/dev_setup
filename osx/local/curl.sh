#!/opt/local/bin/bash
set -x

#ROKU_IP_ADDRESS=10.124.27.72
#ROKU_IP_ADDRESS=10.124.29.135
ROKU_IP_ADDRESS=192.168.1.31
LAUNCH_KEY=dev
LAUNCH_KEY=46041
CYCLE=1
MODE="launch"

while (( "$#" )); do
	case "$1" in
		-ip=*)
			ROKU_IP_ADDRESS="${1:4}"
		;;
		-c=*)
			CYCLE=${1:4}
		;;
		-l | launch)
			MODE="launch"
		;;
		-p | play)
			MODE="play"
		;;
	esac
	shift
done

echo $CYCLE

#Home Rev Fwd Play Select Left Right Down Up Back InstantReplay Info Backspace Search Enter

function launch_press() {
    curl -d '' "http://$ROKU_IP_ADDRESS:8060/launch/$LAUNCH_KEY"
}

function home_press() {
    curl -d '' "http://$ROKU_IP_ADDRESS:8060/keypress/home"
}

function select_press() {
    curl -d '' "http://$ROKU_IP_ADDRESS:8060/keypress/select"
}

launch_cycle() {
    launch_press
    sleep 20s
    home_press
}

play_something() {
    launch_press
    sleep 20s
    select_press
    sleep 300s
    home_press
}


while [ $CYCLE > 0 ]
do
    if [[ $MODE == "launch" ]]; then
        launch_cycle
    elif [[ $MODE == "play" ]]; then
        play_something
    fi
    sleep 10s

    CYCLE=$CYCLE - 1
done

set +x
