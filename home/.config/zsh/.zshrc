# Lines configured by zsh-newuser-install
HISTFILE=~/.cache/zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.config/zsh/.zshrc"

autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
# End of lines added by compinstall
_comp_options+=(globdots)               # Include hidden files.

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi


export VISUAL=micro
export EDITOR=micro

autoload -U colors && colors
[ -f ~/.config/zsh/prompt ] && source ~/.config/zsh/prompt 
[ -f ~/.config/shell/aliases ] && source ~/.config/shell/aliases
[ -f ~/.config/shell/utils_env ] && source ~/.config/shell/utils_env

source /usr/share/autojump/autojump.zsh
# must be last line
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh