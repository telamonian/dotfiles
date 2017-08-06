#!/usr/bin/env bash

# Does all of the steps for squashing a bunch of commits to a homebrew tap.
# Good for final commit before merges.
set -e

# some hardcoded-ish vars
formulaBakupDir=${HOME}/src/formula
gituser=$(git config user.name)

# set up command line parsing via getopts
# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-cd]
Script for the very specific situation of preping a modified formula for submission to homebrew as a pull request. Commits the modified formula to a specific branch of their own fork of the tap, squashes any previous commits to that branch, and then pushes the results.

    -h    Display this help and exit.
    -b    Name of branch specific to the pull request.
    -d    Debug/dry run mode. Print the resolved values of all cmd line args, then echo all of the commands instead of running them.
    -f    Name of modified formula
    -m    Commit message (should be one short line)
    -n    Commit notes. For long form commit messages. Goes underneath the text specified in the -m option in a separate paragraph.
    -t    Dry run. For debug purposes, echo commands instead of running them. Can also be used in conjunction with -r
EOF
}

# Missing required arg error message
missingArgError() {
cat << EOF
ERROR: required argument ${arg} not set

EOF
}

echoArgs() {
    # print args for debugging
    for arg in branch debug formula msgCommit msgNotes tap; do
        echo "${arg}: ${!arg}"
    done
}

# Initialize our own variables:
debug=false

OPTIND=1
# Resetting OPTIND is necessary if getopts was used previously in the script.
# It is a good idea to make OPTIND local if you process options in a function.

while getopts hb:df:m:n:t: opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        b)  branch="$OPTARG"
            ;;
        d)  debug=true
            ;;
        f)  formula="$OPTARG"
            ;;
        m)  msgCommit="$OPTARG"
            ;;
        n)  msgNotes="$OPTARG"
            ;;
        t)  tap="$OPTARG"
            ;;
        *)
            show_help >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))"   # Discard the options and sentinel --

# add ".rb" to the end of formula if it doesn't already have it
if [ ! ${formula: -3} == ".rb" ]; then
    formula=${formula}.rb
fi

# make sure every required arg has been set to at least something
for arg in branch formula msgCommit tap; do
    if [ -z ${!arg+x} ]; then
        missingArgError >&2

        echo "Args are:"
        echoArgs
        echo ""

        show_help >&2
        exit 1
    fi
done

# if debug is set, print all the arg vals and then exit
if [ "$debug" = true ]; then
    echoArgs
    
    # go to appropriate repo dir
    echo cd $(brew --repository homebrew/${tap})
    cd $(brew --repository homebrew/${tap})
    #if the formulae are in a subdir, make sure that's included on the relpath
    if [ -d formula ]; then
        echo formulaRelpath=formula/${formula}
        formulaRelpath=formula/${formula}
    elif [ -d Formula ]; then
        echo formulaRelpath=Formula/${formula}
        formulaRelpath=Formula/${formula}
    else
        echo formulaRelpath=${formula}
        formulaRelpath=${formula}
    fi

    #move changed formula out of repo
    echo mv $formulaRelpath $formulaBakupDir

    #add our fork as remote
    echo git remote add ${gituser} https://github.com/${gituser}/homebrew-${tap}.git

    #git all changes and reset the repo
    echo git fetch --all
    echo git reset --hard origin/master
    echo git checkout ${branch}
    echo git reset --hard origin/master

    #copy the changed formula back into the repo
    echo cp $formulaBakupDir/${formula} $formulaRelpath

    #commit the changed formula. This is where the actual squash happens.
    echo git add $formulaRelpath
    echo "Commit message:"
    echo "${msgCommit}"
    echo "Commit notes:"
    echo "${msgNotes}"
    echo git commit -m "${msgCommit}" -m "${msgNotes}"

    echo git push -f ${gituser} ${branch}
fi

# go to appropriate repo dir
cd $(brew --repository homebrew/${tap})
# if the formulae are in a subdir, make sure that's included on the relpath
if [ -d formula ]; then
    formulaRelpath=formula/${formula}
elif [ -d Formula ]; then
    formulaRelpath=Formula/${formula}
else
    formulaRelpath=${formula}
fi

# move changed formula out of repo
cp $formulaRelpath $formulaBakupDir

# add our fork as remote. If already added, this fails, so temporarily turn off strict error checking
set +e
git remote add ${gituser} https://github.com/${gituser}/homebrew-${tap}.git
set -e

# git all changes and reset the repo
git fetch --all
git reset --hard origin/master
git checkout ${branch}
git reset --hard origin/master

# copy the changed formula back into the repo
cp $formulaBakupDir/${formula} $formulaRelpath

# commit the changed formula. This is where the actual squash happens.
git add $formulaRelpath
echo "Commit message:"
echo "${msgCommit}"
echo "Commit notes:"
echo "${msgNotes}"
git commit -m "${msgCommit}" -m "${msgNotes}"

git push -f ${gituser} ${branch}
