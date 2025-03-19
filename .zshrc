#
# ~/.zshrc
#

# History in cache directory
HISTSIZE=5000
SAVEHIST=5000
HISTFILE=$XDG_CACHE_HOME/zsh/history

# Stop weird glob behaviour
unsetopt nomatch

# Ignore dupes in history
setopt hist_ignore_all_dups

# Allows fun stuff in prompts
setopt prompt_subst

typeset -a precmd_functions

# Basic auto/tab complete
 autoload -U compinit
 zstyle ":completion:*" menu select
 zmodload zsh/complist
 compinit
 _comp_options+=(globdots)   # Include hidden files

# Activate vi mode
bindkey -v

# Remove mode switching delay
KEYTIMEOUT=5

# Change cursor shape for different vi modes
function zle-keymap-select {
    if [[ ${KEYMAP} == vicmd ]] ||
        [[ $1 = "block" ]]; then
    echo -ne "\e[2 q"
    elif [[ ${KEYMAP} == main ]] ||
        [[ ${KEYMAP} == viins ]] ||
        [[ ${KEYMAP} = "" ]]; then
    echo -ne "\e[6 q"
    fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # init "vi insert" as keymap
}
zle -N zle-line-init
# Make sure cursor is beam by default
_beam_cursor() {
    echo -ne "\e[6 q"
}
precmd_functions+=(_beam_cursor)

# Use vi keys in tab complete menu
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -v "^?" backward-delete-char

# Enable colours
autoload -U colors && colors

# Set prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ":vcs_info:git*" formats "%F{yellow}%b%f "

_set_prompt() {
    vcs_info

    # Prompt start
    PROMPT="%B%F{green}%n%f@%F{blue}%m%f%b: "

    if [[ ! -z ${vcs_info_msg_0_} ]]; then
        PROMPT+="${vcs_info_msg_0_}"
    fi

    # Prompt end
    PROMPT+="%1~ %B>%b "
}
precmd_functions+=(_set_prompt)


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
