#!/usr/bin/bash

/home/rokudev/phoenix_rsync/build/libs/qt/roku_arm/bin/qmake /home/rokudev/phoenix_rsync/phoenix_subdirs.pro -spec devices/linux-roku-arm-g++ CONFIG+=debug CONFIG+=qml_debug && /usr/bin/make qmake_all


export PATH=$PATH:/home/rokudev/phoenix_rsync/build/libs/roku_ndk/platforms/Roku2/toolchain/bin

pushd /home/rokudev/phoenix_rsync/build-phoenix_subdirs-rsync-Debug
make -j2
echo "sleep"
sleep 1
make install -j2
sleep 1
popd
