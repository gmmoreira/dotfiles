#!/usr/bin/env bash

# https://github.com/anordal/shellharden/blob/master/how_to_do_things_safely_in_bash.md
if test "$BASH" = "" || "$BASH" -uc "a=();true \"\${a[@]}\"" 2>/dev/null; then
    # Bash 4.4, Zsh
    set -euo pipefail
else
    # Bash 4.3 and older chokes on empty arrays with set -u.
    set -eo pipefail
fi
shopt -s nullglob globstar

function command_exists() {
  command -v "$1" > /dev/null 2>&1
}

required_commands=("stow" "curl" "git")

for c in "$required_commands"
do
  command_exists "$c" || { echo "$c command not available"; exit 1; }
done

local_dir="${HOME}/.local"
packages=("gem" "tmux" "ctags" "git" "intellij")
stow_verbosity=2
stow -t "$HOME" \
  -v "$stow_verbosity" \
  -S "${packages[@]}"

# Vim
if command_exists "nvim"; then
  # Plug not exists?
  if [[ ! -f ~/.local/share/nvim/site/autoload/plug.vim ]]; then
    echo "Plug plugin not exists for neovim"
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  mkdir -p ~/.config/nvim
  stow -t "$HOME/.config/nvim" \
    -d vim/.config \
    -v "$stow_verbosity" \
    nvim

fi

if command_exists "vim"; then
  if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
    echo "Plug plugin not exists for vim"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi

  stow -t "$HOME" \
    -v "$stow_verbosity" \
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
[[ -f "${local_dir}/bin/rb" ]] || { curl https://raw.githubusercontent.com/thisredone/rb/master/rb -o "${local_dir}/bin/rb" && chmod +x "${local_dir}/bin/rb"; }

# Java
if [[ ! -s ~/.sdkman/bin/sdkman-init.sh ]]; then
  curl -s "https://get.sdkman.io" | bash
fi

sys_name="$(uname -s)"
case "$sys_name" in
  Darwin*)    pushd ./macos; ./install.sh; popd;;
  Linux*)     pushd ./linux; ./install.sh; popd;;
  *)          echo "$sys_name is not configured";;
esac

mkdir -p ~/workspace/work
