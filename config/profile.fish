set -gx GOBIN $HOME/go/bin
if test -d $GOBIN
  if not string match -q -- $GOBIN $PATH
    set -gx PATH "$GOBIN" $PATH
  end
end

alias sfish="source ~/.config/fish/config.fish"
alias cpfish="nvim ~/.profile.fish"
alias cfish="cd ~/.config/fish; nvim ~/.config/fish/config.fish"

alias cstarship="nvim ~/.config/starship.toml"

alias cnvim="cd ~/.config/nvim; nvim ~/.config/nvim/init.lua"

alias cdw="cd ~/Workspaces"
alias cdwp="cd ~/Workspaces/personal"
alias cdwc="cd ~/Workspaces/company"

alias susedot="cd ~/Workspaces/personal/suse-dotfiles"
alias archdot="cd ~/Workspaces/personal/arch-dotfiles"
alias macdot="cd ~/Workspaces/personal/mac-dotfiles"
alias ubuntudot="cd ~/Workspaces/personal/ubuntu-dotfiles"

alias chmox="chmod +x"
