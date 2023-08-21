set fish_greeting
source $HOME/.profile.fish

set -gx CARGO_BIN $HOME/.cargo/bin
if test -d $CARGO_BIN
  if not string match -q -- $CARGO_BIN $PATH
    set -gx PATH "$CARGO_BIN" $PATH
  end
end

starship init fish | source

if test -f "$HOME/.config/fish/conf.d/base16.fish"
	base16-gruvbox-dark-hard
end

if test -d "$HOME/.config/fish/conf.d/nvm.fish"
	nvm use latest --silent
end
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
	set -gx PATH "$PNPM_HOME" $PATH
end
alias npm="pnpm"
