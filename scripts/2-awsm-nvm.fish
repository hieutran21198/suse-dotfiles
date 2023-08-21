#!/usr/bin/env fish

fisher install jorgebucaran/nvm.fish
if test $status -ne 0
	echo "An error occurred while installing nodejs-common."
	exit $status
end

set FISH_CONF_FILE "$HOME/.config/fish/config.fish"

source $FISH_CONF_FILE

nvm install latest
echo "nvm with 'node latest' installed successfully."

if grep -qF "conf.d/nvm.fish" $FISH_CONF_FILE
	echo "added nvm to config.fish"
else
	echo  "\

if test -d \"\$HOME/.config/fish/conf.d/nvm.fish\"
	nvm use latest --silent
end" >> $FISH_CONF_FILE
end

nvm use latest

npm install -g pnpm
echo "pnpm install successfully"

if grep -qF "set -gx PNPM_HOME" $FISH_CONF_FILE
	echo "pnpm home already defined"
else
	echo "\
set -gx PNPM_HOME \"\$HOME/.local/share/pnpm\"
if not string match -q -- \$PNPM_HOME \$PATH
	set -gx PATH \"\$PNPM_HOME\" \$PATH
end" >> $FISH_CONF_FILE
end

if grep -qF "alias npm=" $FISH_CONF_FILE
	echo "npm alias already defined in config.fish"
else
	echo "alias npm=\"pnpm\"" >> $FISH_CONF_FILE
end
