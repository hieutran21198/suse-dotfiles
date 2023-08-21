#!/usr/bin/env fish

fisher install FabioAntunes/base16-fish-shell

source "$HOME/.config/fish/config.fish"

set BASE16_CURRENT_THEME "base16-gruvbox-dark-hard"

set FISH_CONFIG_FILE "$HOME/.config/fish/config.fish"

if not grep -qF $BASE16_CURRENT_THEME $FISH_CONFIG_FILE
	echo "\
if test -f \"\$HOME/.config/fish/conf.d/base16.fish\"
	$BASE16_CURRENT_THEME
end" >> $FISH_CONFIG_FILE 
	echo "applied $BASE16_CURRENT_THEME to fish shell" 
end
