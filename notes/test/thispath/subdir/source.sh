# vim: filetype=bash

THIS_PATH=$(thispath $BASH_SOURCE)
THIS_DIR=$(thisdir $BASH_SOURCE)
THIS_PARENT=$(thisparent $BASH_SOURCE)

echo $THIS_PATH
echo $THIS_DIR
echo $THIS_PARENT
