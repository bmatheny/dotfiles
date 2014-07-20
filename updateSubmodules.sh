#!/bin/bash

# Script variables
US_debug=false
US_home=$PWD
US_gitcmd="git"
US_gitpull=false
US_quiet=false
US_testonly=false

# Return the submodule configured branch, the branch it's on, or master
function current_branch () {
local module=$1
# Grab the configured branch if it exists
local branch=$($US_gitcmd config -f $US_home/.gitmodules --get submodule.${module}.branch)

# Otherwise grab the branch the submodule is on
if [ -z "$branch" ]; then
  branch=$($US_gitcmd rev-parse --abbrev-ref HEAD 2> /dev/null | grep -v HEAD)
fi

# Otherwise set the branch to master
if [ -z "$branch" ]; then
  branch="master"
fi
echo $branch
}

# exit 0 if we are missing git sub directories, otherwise exit 1
function needs_init() {
for module in $($US_gitcmd submodule status | awk '{print $2}'); do
  if [ ! -f "$module/.git" ]; then
    return 0
  fi
done
return 1
}

# descend into submodules running checkout/pull
function updateModules() {
for module in $($US_gitcmd submodule status | awk '{print $2}'); do
  cd $module
  branch=$(current_branch $module)
  qa="-q"
  if $US_testonly; then
    echo "TEST(exec): cd $module && $US_gitcmd checkout $qa $branch && $US_gitcmd pull $qa origin $branch && cd $US_home"
  else
    echo "Submodule(name=$module, branch=$branch): checkout and pull"
    $US_gitcmd checkout $qa $branch && $US_gitcmd pull $qa origin $branch
  fi
  cd $US_home
done
}

function usage() {
cat << EOF
usage: $0 [options]

This script handles managing project submodules.

OPTIONS:
    -g CMD command to use instead of 'git' (e.g. proxycmd.sh git)
    -h     This help
    -p     Also decend into submodules and git checkout/pull
    -q     Quiet
    -t     Test mode. Only show commands that would be run.
EOF
}

while getopts "dg:hpqt" OPTION
do
  case $OPTION in
    d)
      US_debug=true
      ;;
    g)
      US_gitcmd=$OPTARG
      ;;
    h)
      usage
      exit 1
      ;;
    p)
      US_gitpull=true
      ;;
    t)
      US_testonly=true
      ;;
    q)
      US_quiet=true
      ;;
    ?)
      usage
      exit
      ;;
  esac
done

if $US_debug; then
  set -x
fi

echo "Repository(root=$US_home): Starting updates"
echo "Options(debug=$US_debug, git='$US_gitcmd', pull=$US_gitpull, quiet=$US_quiet, test=$US_testonly)"

if needs_init; then
  echo "Repository(root=$US_home): Initializing submodules for first time, this may take a while"
  if $US_testonly; then
    echo "TEST(exec) - $US_gitcmd submodule update --init --quiet --recursive"
  else
    $US_gitcmd submodule update --init --quiet --recursive
  fi
else
  echo "Repository(root=$US_home): Updating submodules (initialization not needed)"
  if $US_testonly; then
    echo "TEST(exec) - $US_gitcmd submodule update --quiet --rebase --remote"
  else
    $US_gitcmd submodule update --quiet --rebase --remote
  fi
fi

if $US_gitpull; then
  echo "Repository(root=$US_home): running git checkout/pull on all submodules"
  updateModules
fi

echo "Repository(root=$US_home): Updates finished"
echo "Repository(root=$US_home): Status of repository below"

echo "--------------------------------------------------------------------------------"
$US_gitcmd status
echo "--------------------------------------------------------------------------------"

echo "Repository(root=$US_home): Status of submodules below"
echo "--------------------------------------------------------------------------------"
$US_gitcmd submodule status
echo "--------------------------------------------------------------------------------"

exit 0
