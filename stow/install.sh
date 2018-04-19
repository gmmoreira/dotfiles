#!/bin/bash

function command_exists() {
  command -v $1 > /dev/null 2>&1
}

command_exists "stow" || { echo "stow command not available"; exit 1; }
command_exists "curl" || { echo "curl command not available"; exit 1; }
command_exists "git" ||  { echo "git command not available"; exit 1; }

stow -t $HOME \
  -v 2 \
  -S gem tmux ctags git

# Vim
if command_exists "nvim"; then
  # Plug not exists?
  if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
    echo "Plug plugin not exists for neovim"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  mkdir -p ~/.config/nvim
  stow -t ~/.config/nvim \
    -d vim/.config \
    -v 2 \
    nvim

fi

if command_exists "vim"; then
  if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    echo "Plug plugin not exists for vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  stow -t ~/ \
    -v 2 \
    --ignore .config \
    vim
fi

# Colors
if [[ ! -d ~/.config/base16-shell ]]; then
  git clone https://github.com/chriskempson/base16-shell.git ~/.config/base16-shell
fi

# Ruby
if [[ ! -d ~/.rbenv ]]; then
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  pushd ~/.rbenv && src/configure && make -C src
  popd
  export PATH="$HOME/.rbenv/bin:$PATH"
  mkdir -p "$(rbenv root)"/plugins
  git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build
fi

# Java
if [[ ! -s ~/.sdkman/bin/sdkman-init.sh ]]; then
  curl -s "https://get.sdkman.io" | bash
fi

sys_name=`uname -s`

case $sys_name in
  Darwin*)    pushd ./macos; ./install.sh; popd;;
  Linux*)     pushd ./linux; ./install.sh; popd;;
  *)          echo "$sys_name is not configured";;
esac
