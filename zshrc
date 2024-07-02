# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

zstyle ':omz:update' mode auto      # update automatically without asking

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git archlinux zsh-autosuggestions command-not-found vi-mode zsh-syntax-highlighting git-prompt z)

VI_MODE_SET_CURSOR=true

unsetopt inc_append_history
unsetopt share_history

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
export ARCHFLAGS="-arch arm64"


export KEYTIMEOUT=1
export PYTHONDONTWRITEBYTECODE=1

alias rm="rm -i"
alias cp="cp -i"
alias mv="mv -i"
alias lt="ls -ltr"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#5c6370"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion)

setopt nobeep

# for git hook
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn

precmd() {
    vcs_info
}

setopt prompt_subst

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'


PS1='%F{magenta}%~%f %(!.%B#%b.%F{blue}%B❯%b%f) '
PS2=$'%1_>'

function zle-line-init zle-keymap-select {
    EPS1="$(git_prompt_info) %{$reset_color%} %(0?..[%?])"
    VIM_PROMPT="%{$fg_bold[green]%} [% N]% %{$reset_color%}"
    VIM_PROMPT1="%{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(viins|main)/} $EPS1"
    zle reset-prompt
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_no_bold[magenta]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_no_bold[magenta]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_no_bold[magenta]%}) %{$fg[green]%}✓"

zle -N zle-line-init
zle -N zle-keymap-select

# change highlighting defaults ... 
# see https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/docs/highlighters/main.md
# ZSH_HIGHLIGHT_STYLES[path]='fg=magenta'


# autocomplete style
#


# zstyle ':autocomplete:recent-dirs' backend zsh-z
# zstyle ':autocomplete:*' widget-style menu-complete
# zstyle ':autocomplete:*' insert-unambiguous yes
# 
# zle -A {.,}history-incremental-search-forward
# zle -A {.,}history-incremental-search-backward
#
# eval "$(dircolors -b ~/.config/dircolors)"




# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/daniel/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/daniel/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/daniel/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/daniel/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


export PATH=$PATH:$HOME/bin:/usr/local/bin:$HOME/.local/bin
export JULIA_PKG_USE_CLI_GIT=true

alias s="kitty +kitten ssh"

alias vim="nvim"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/daniel/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
