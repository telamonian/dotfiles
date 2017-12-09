#!/usr/bin/env bash
# some common vars used by several bash files in this package

# relative paths (with respect to ABS_DOT_ROOT)
DOT_BASH="bash_profile.d"
DOT_BUNDLE="bundle_spec.d"
DOT_HOME="home.d"
DOT_SETTING="setting.d"
DOT_VM="virtual_machine.d"

# absolute paths
ABS_DOT_ROOT=$(cd "$(dirname "$(stat -f "${BASH_SOURCE}")")"/.. && pwd -P)

