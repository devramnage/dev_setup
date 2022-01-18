build_name="sling_roku_arm_Debug-0.0.0.0.bin"
host_ip="10.124.27.181"
dest="/Users/Holbrook/Desktop"

rsync -v -a -e ssh build/builds/${build_name} Holbrook@${host_ip}:${dest}
