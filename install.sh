#!/usr/bin/env bash

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

mkdir -p $HOME/.config
ln -sf $DOTFILES_DIR/nvim $HOME/.config/nvim
