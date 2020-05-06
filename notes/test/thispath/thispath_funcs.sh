#!/usr/bin/env bash
# vim: filetype=bash

## func for getting the real pth to a script
## (regardless of aliases). Takes $BASH_SOURCE as first arg
## ref: https://stackoverflow.com/a/246128/425458
thispath()
{
    SOURCE_LIST=$1
    SOURCE="${SOURCE_LIST[0]}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
        DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
        SOURCE="$(readlink "$SOURCE")"
        [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done

    _THIS_DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
    _THIS_NAME="$(basename "$SOURCE")"
    echo "$(ls -d "$_THIS_DIR"/"$_THIS_NAME")"
}

## func for getting the real pth to a script's
## dir (regardless of aliases). Takes $BASH_SOURCE as first arg
thisdir()
{
    SOURCE="$(thispath "$1")"
    echo "$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
}

## func for getting the real pth to a script's parent
## dir (regardless of aliases). Takes $BASH_SOURCE as first arg
thisparent()
{
    SOURCE="$(thispath "$1")"
    echo "$( cd -P "$( dirname "$SOURCE" )"/.. >/dev/null 2>&1 && pwd )"
}

THIS_PATH=$(thispath $BASH_SOURCE)
THIS_DIR=$(thisdir $BASH_SOURCE)
THIS_PARENT=$(thisparent $BASH_SOURCE)

echo $THIS_PATH
echo $THIS_DIR
echo $THIS_PARENT

source $THIS_DIR/subdir/source.sh
