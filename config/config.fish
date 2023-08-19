set fish_greeting
source $HOME/.profile.fish

starship init fish | source

if test -d "$HOME/.config/fish/conf.d/nvm.fish"
	nvm use lts
end
