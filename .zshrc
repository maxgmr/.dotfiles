#
# ~/.zshrc
#

# If not running interactively, don't do anything
if [[ -o login ]]; then
    return
fi

# History in cache directory
HISTSIZE=5000
SAVEHIST=5000
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

# Enable colours
autoload -U colors && colors

# Set prompt
PROMPT="%B%F{green}%n%f@%F{blue}%m%f%b: %1~ %B>%b "

# Stop git tab completion freeze
__git_files () {
    _wanted files expl 'local files' _files
}

# Aliases
alias cl="clear"
alias ex="exit"
alias ls="lsd"
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias sp="nvim $HOME/scratchpad"
alias obsidian="OBSIDIAN_USE_WAYLAND=1 obsidian -enable-features=UseOzonePlatform -ozone-platform=wayland"

# Enable syntax highlighting
# Make sure the plugin is installed! (https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
