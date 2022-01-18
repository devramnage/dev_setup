#!/bin/bash

set -x
CONFIG_NAME=sling/config.json

while (( "$#" )); do
    case "$1" in
        -p)
            CONFIG_NAME=sling/configv2.json
            ;;
        -v=*)
            MIN_VERSION="${1:3}"
            ;;
        -s=*)
            SR_NUMBER="${1:3}"
            ;;
    esac
    shift
done

updateMinVersions() {
    ENVIRONMENT=$1
    git checkout $ENVIRONMENT
    if [ $? != 0 ] ; then
        exit 1
    fi

    git reset --hard origin/$ENVIRONMENT
    if [ $? != 0 ] ; then
        exit 1
    fi
    git checkout -b $SR_NUMBER-$ENVIRONMENT
    if [ $? != 0 ] ; then
        git branch -D $SR_NUMBER-$ENVIRONMENT
        if [ $? != 0 ] ; then
            exit 1
        fi
        git checkout -b $SR_NUMBER-$ENVIRONMENT
        if [ $? != 0 ] ; then
            exit 1
        fi
    fi

    sed -i.bu '2s/"required_version".*/"required_version" : "'$MIN_VERSION'",/' $CONFIG_NAME

    git add $CONFIG_NAME
    git commit -m "Update minimum versions to $MIN_VERSION"

    git push origin $SR_NUMBER-$ENVIRONMENT

    #TODO create pull requests
    #TODO update SR description
}




#We do not update the dev config regularly
#updateMinVersions dev
updateMinVersions qa
updateMinVersions beta
updateMinVersions prod

set +x
