#
# ~/.zshrc
#

# If not running interactively, don't do anything
if [[ -o login ]]; then
    return
fi

# History in cache directory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$XDG_CACHE_HOME/zsh/history

# Basic auto/tab complete
autoload -U compinit
zstyle ":completion:*" menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)   # Include hidden files

# Use vim keys in tab complete menu
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -v "^?" backward-delete-char

# Add zsh-vi-mode
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Enable colours
autoload -U colors && colors

# Set prompt
PROMPT="%B%F{green}%n%f@%F{blue}%m%f%b: %1~ %B>%b "

# Aliases
alias cl="clear"
alias ex="exit"
alias ls="lsd"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias sp="nvim $HOME/scratchpad"
alias obsidian="OBSIDIAN_USE_WAYLAND=1 obsidian -enable-features=UseOzonePlatform -ozone-platform=wayland"
