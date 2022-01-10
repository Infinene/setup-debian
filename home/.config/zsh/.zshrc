# Lines configured by zsh-newuser-install
HISTFILE=~/.config/zsh/histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/am/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
  PATH="$HOME/bin:$PATH"
fi

[ -f ~/.config/zsh/aliases ] && source ~/.config/zsh/aliases 
[ -f ~/.config/zsh/prompt ] && source ~/.config/zsh/prompt 

export VISUAL=micro
export EDITOR=micro

# nnn filemanager
export NNN_PLUG='p:-!less -iR $nnn*;b:-!bat --paging=always $nnn*'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export NNN_COLORS='2356'

# composer memory limit if not set in php cli ini
# export COMPOSER_MEMORY_LIMIT=-1
# . "/home/aom/.acme.sh/acme.sh.env"

screenfetch