#!/bin/sh

command -v stow > /dev/null 2>&1 || (echo "stow command not available" && exit 1)

stow -t $HOME --ignore "install.sh" -v 2 \
  -S bash
