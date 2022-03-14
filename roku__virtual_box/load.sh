set -x
BUILD_TYPE=dev
#ROKU_ARCHITECTURE=roku_paolo
ROKU_ARCHITECTURE=roku_arm
PLAYER_FLAGS="athena disable_ap"
UPLOAD_TO_ROKU=true
BUILD_APPLICATION=true
ROKU_IP_ADDRESS=10.124.27.70
ROKU_IP_ADDRESS=192.168.1.213
ROKU_DEVELOPER_PASSWORD=aaaa
#ROKU_DEVELOPER_PASSWORD=1234
#ROKU_DEVELOPER_PASSWORD=1111

while (( "$#" )); do
	case "$1" in
		-a=*)
			ROKU_ARCHITECTURE="${1:3}"
		;;
		athena)
			PLAYER_FLAGS="athena disable_ap"
		;;
		disable_ap)
			PLAYER_FLAGS=disable_ap
		;;
		-b=*)
			BUILD_TYPE="${1:3}"
		;;
		build_only)
			UPLOAD_TO_ROKU=false
		;;
		upload_only)
			BUILD_APPLICATION=false
		;;
		-ip=*)
			ROKU_IP_ADDRESS="${1:4}"
		;;
	esac
	shift
done

#change directory to script directory so this can be run from any directory
pushd "${0%/*}"

if $BUILD_APPLICATION; then
	rm ../installs/roku_arm_qml*
	./build.sh
fi

for build_name in ../installs/roku_arm_qml*; do
	BUILD_PATH=$build_name
done

if [[ $UPLOAD_TO_ROKU && -f "$BUILD_PATH" ]]; then
	../tools/roku/package_utils.sh delete -i ${ROKU_IP_ADDRESS} -p $ROKU_DEVELOPER_PASSWORD
	../tools/roku/package_utils.sh upload -i ${ROKU_IP_ADDRESS} -p $ROKU_DEVELOPER_PASSWORD -f "$BUILD_PATH"
fi

#return to previous directory
popd

set +x
