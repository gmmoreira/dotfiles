#!/bin/sh

command -v stow > /dev/null 2>&1 || (echo "stow command not available" && exit 1)

sys_name=`uname -s`

case $sys_name in
  Darwin*)    pushd ./macos; ./install.sh; popd;;
  *)          echo "$sys_name is not configured";;
esac

stow -t $HOME --ignore "install.sh" -v 2 \
  -S gem
