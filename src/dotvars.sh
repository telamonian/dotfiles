#!/usr/bin/env bash
# some common vars used by several bash files in this package

if [ -z "${DOT_REPO}" ]; then echo "DOT_REPO not defined" >&2; exit 1; fi


# relative paths (with respect to DOT_REPO)
DOT_BASH="bash_profile.d"
DOT_BUNDLE="bundle_spec.d"
DOT_HOME="home.d"
DOT_SETTING="setting.d"
DOT_VM="virtual_machine.d"

# absolute paths
#DOT_REPO=$(thisparent $BASH_SOURCE)
