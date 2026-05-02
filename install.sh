#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# mise
mkdir -p $HOME/.config/mise
ln -sf $DOTFILES_DIR/mise/config_toml $HOME/.config/mise/config.toml
touch $HOME/.config/mise/config.local.toml

# nvim
mkdir -p $HOME/.config
ln -sf $DOTFILES_DIR/nvim $HOME/.config/

# tmux
ln -sf $DOTFILES_DIR/.tmux.conf ~/.tmux.conf

# gitconfig
touch ~/.gitconfig.local
ln -sf $DOTFILES_DIR/.gitconfig ~/.gitconfig

# bashrc
BASHRC_PATH="$DOTFILES_DIR/.bashrc"
LINE="[ -f $BASHRC_PATH ] && source $BASHRC_PATH"
grep -qxF "$LINE" ~/.bashrc || echo "$LINE" >> ~/.bashrc
