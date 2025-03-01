#
# ~/.bashrc
#

# Get env vars
export $(envsubst <$HOME/.config/env)

# PATH STUFF
# Cargo
PATH="$PATH:$HOME/.cargo/bin"
PATH="$PATH:$HOME/.cargo/env"
# Ruby gems
PATH="$PATH:$HOME/computer/gems/bin"
PATH="$PATH:$HOME/.local/share/gem/ruby/3.0.0/bin"
# Config binaries
PATH="$PATH:$HOME/.config/bin"
# Cross-compiler
PATH="$PATH:$HOME/opt/cross_i686-elf/bin"

export PATH

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

# PS1='[\u@\h \W]\$ '
# PS1='\e[1m[\e[34m\u\e(B\e[m\e[1m@\e[36m\h\e(B\e[m\e[1m \W]\$\e(B\e[m '
# PS1='\[\e[1m\][\[\e[34m\]\u\[\e(B\e[m\e[1m\]@\[\e[36m\]\h\[\e(B\e[m\e[1m\] \W]\[\$\e(B\e[m\] '
# PS1='\[\e[1m\][\A \[\e[1;32m\]\u\[\e[m\e[1m\]@\[\e[1;36m\]\h \[\e[m\]\W\[\e[1m\]]\[\]\$ \[\e[m\]'
PS1='\[\e[1m\]\[\e[1;32m\]\u\[\e[m\e[1m\]@\[\e[1;34m\]\h\[\e[m\]: \W \[\e[1m\]\[\]\$ \[\e[m\]'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] &&
    [ -s "$BASE16_SHELL/profile_helper.sh" ] &&
    source "$BASE16_SHELL/profile_helper.sh"
base16_max-dark

# Install Ruby Gems to ~/computer/gems
export GEM_HOME="$HOME/computer/gems"

# Aliases
alias cl='clear'
alias rmi='rm -i'
alias browsepackages="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias ex='exit'
alias dcss='crawl-tiles'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias sc="source sc"
alias sp="nvim /home/$USER/scratchpad"
alias ls="lsd"
alias obsidian="OBSIDIAN_USE_WAYLAND=1 obsidian -enable-features=UseOzonePlatform -ozone-platform=wayland"
