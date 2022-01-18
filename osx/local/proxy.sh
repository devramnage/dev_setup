set -x

pushd "${0%/*}"

ROKU_IP_ADDRESS=10.124.27.70
HOST_IP_ADDRESS="$(./ip_address.sh)"

curl -d "" "http://${ROKU_IP_ADDRESS}:8060/launch/dev?contentId=devopt%7Cproxyip%3D${HOST_IP_ADDRESS}"

set +x
