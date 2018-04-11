#!/bin/sh

function command_exists() {
  command -v $1 > /dev/null 2>&1
}

command_exists "stow" || { echo "stow command not available"; exit 1; }

stow -t $HOME \
  -v 2 \
  -S gem tmux

# Vim
if command_exists "nvim"; then
	[[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]] && curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	mkdir -p ~/.config/nvim
	stow -t ~/.config/nvim \
	  -d vim/.config \
	  -v 2 \
	  nvim

fi

if command_exists "vim"; then
	[[ ! -f ~/.vim/autoload/plug.vim ]] && curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	stow -t ~/ \
	  -v 2 \
	  --ignore .config \
	  vim
fi

sys_name=`uname -s`

case $sys_name in
  Darwin*)    pushd ./macos; ./install.sh; popd;;
  *)          echo "$sys_name is not configured";;
esac
