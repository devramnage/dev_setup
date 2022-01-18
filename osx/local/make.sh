#!/opt/local/bin/bash

pushd "${0%/*}"
qmake ../phoenix.pro

pushd ../build-phoenix-Desktop-Debug
make -j8
make install -j8
popd
popd
