#!/usr/bin/env bash

rm -rf ~/.config/nvim
ln -s $(pwd)/config/nvim ~/.config/nvim

rm -rf ~/.config/starship.toml
ln -s $(pwd)/config/starship.toml ~/.config/starship.toml

mkdir -p ~/.config/fish
rm -rf ~/.config/fish/config.fish
ln -s $(pwd)/config/config.fish ~/.config/fish/config.fish

rm -rf ~/.profile.fish
ln -s $(pwd)/config/profile.fish ~/.profile.fish
