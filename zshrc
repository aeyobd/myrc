# If you come from bash you might have to change your $PATH.


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"


# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

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

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# Compilation flags
export ARCHFLAGS="-arch x86_64"


export KEYTIMEOUT=1
export PYTHONDONTWRITEBYTECODE=1
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# PS1=%{$fg_bold[green]%}%p %{$fg_bold[blue]%}%c $(git_prompt_info)% %{$fg_bold[green]%} $ %{$reset_color%}
# alias vim="vim"
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

# RPROMPT=$'${vcs_info_msg_0_}'
# 
# lowers timeout

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

alias s="kitty +kitten ssh"

alias vim="nvim"
