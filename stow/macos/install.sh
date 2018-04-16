#!/bin/bash

command -v stow > /dev/null 2>&1 || (echo "stow command not available" && exit 1)

if [[ ! -d ~/.bash-git-prompt ]]; then
  git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1
fi

stow -t $HOME \
  -v 2 \
  -S bash
