#!/usr/bin/env fish

fisher install jorgebucaran/nvm.fish
if test $status -ne 0
	echo "An error occurred while installing nodejs-common."
	exit $status
end

source ~/.config/fish/config.fish

nvm install lts
echo "nvm with 'node lts' installed successfully."


if grep -qF "conf.d/nvm.fish" "$HOME/.config/fish/config.fish"
	echo "added nvm to config.fish"
else
	echo  "\

if test -d \"\$HOME/.config/fish/conf.d/nvm.fish\"
	nvm use lts
end" >> "$HOME/.config/fish/config.fish"
end
