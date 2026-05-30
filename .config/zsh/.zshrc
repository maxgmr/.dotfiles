local zsh_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$zsh_cache" ]] || mkdir -p "$zsh_cache"

local dotdir="${ZDOTDIR:-$HOME}"

local block="\e[2 q"
local beam="\e[6 q"


# =======
# HISTORY
# =======

HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$zsh_cache/history"

# Ignore dupes in history
setopt hist_ignore_all_dups

# Don't include commands starting with a space in history
setopt hist_ignore_space

# See history from all processes
setopt share_history
# Bash-style matching
unsetopt nomatch


# ======
# PROMPT
# ======

setopt prompt_subst

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git*' formats "%F{magenta}%b%f"

_set_prompt() {
	vcs_info

	PROMPT="%B%F{blue}%n%f@%F{green}%m%f%b %F{yellow}%1~%f"

	if [[ -n ${vcs_info_msg_0_} ]]; then
		PROMPT+="|${vcs_info_msg_0_}"
	fi

	PROMPT+=" %B>%b "
}
precmd_functions+=(_set_prompt)


# ==========
# COMPLETION
# ==========

autoload -U compinit

# Cache compinit to speed up startup time (checks once a day)
local zcompdump="$zsh_cache/.zcompdump"
if [[ -n $(find "$zcompdump" -mtime -1 2>/dev/null) ]]; then
	compinit -C -d "$zcompdump"
else
	compinit -d "$zcompdump"
fi

# Basic menu
zstyle ':completion:*' menu select
# Load complist module
zmodload zsh/complist
# Match 'ls' colours
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# Group results by category
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%F{blue}-- %d --%f'

# Include hidden files in completion
_comp_options+=(globdots)

# Stop git tag completion freeze (fallback hack)
__git_files () {
	_wanted files expl 'local files' _files
}


# ==
# VI
# ==

# Activate vi mode
bindkey -v

# Drop into normal mode faster
KEYTIMEOUT=5

# Always start in insert mode
zle-line-init() {
	zle -K viins
}
zle -N zle-line-init

# Change cursor shape for different vi modes
function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = "block" ]]; then
		print -n "$block"
	else
		print -n "$beam"
	fi
}
zle -N zle-keymap-select

# Always start with beam cursor for new prompts
_beam_cursor() {
	print -n "$beam"
}
precmd_functions+=(_beam_cursor)

# Return to block cursor right before executing a command
zle-line-finish() {
	print -n "$block"
}
zle -N zle-line-finish

# Use vi keys in tab complete menu
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -v "^?" backward-delete-char


# ====
# MISC
# ====

# Add final term control sequences
autoload -Uz add-zsh-hook
ftcs_precmd() { print -Pn '\e]133;D\e\\' }
add-zsh-hook precmd ftcs_precmd
ftcs_preexec() { print -Pn '\e]133;C\e\\' }
add-zsh-hook preexec ftcs_preexec

# =======
# ALIASES
# =======

source "$dotdir/aliases.zsh"


# ====
# PATH
# ====

# Support local binaries
export PATH="$HOME/.local/bin:$PATH"

# Deduplicate PATH
typeset -U PATH path
