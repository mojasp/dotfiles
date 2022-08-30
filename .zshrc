# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/bin/bin:$HOME/bin:/$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/moritz/.oh-my-zsh"
export TERMINAL="alacritty"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# t-o0-0 know which specific one was loaded, run: echo $RANDOM_THEME
#

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/ If set to an empty array, this variable will have no effect.  ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )
ZSH_THEME="avit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

unsetopt correctall
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

export FZF_BASE=~/.config/nvim/autoload/fzf
# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Add wisely, as too many plugins slow down shell startup.
#

plugins=(
  zsh-dircolors-solarized
  fzf
  vi-mode
  tmux
  git
  extract #swiss army knife extract
  colored-man-pages
  colorize #cat with syntax highlight
  command-not-found #suggest package if cmd not found
  poetry
)
source $ZSH/oh-my-zsh.sh

#zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
#autoload -Uz compinit
#compinit

RPROMPT=''

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

export EDITOR='nvim'
export VISUAL='nvim'
bindkey -v

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias ll="lsd -lh"
alias l="lsd -lah"
alias cdp="cd ~/Documents/Studium/Praktikum"
alias gdbdash="tmux send-keys -t .0 gdb Space -ex Space \'dashboard Space -output Space `tty`\' Space Enter; tmux select-pane -t .0"
alias vi="nvim"
alias vim="nvim"

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin \
                                           /usr/local/bin  \
                                           /usr/sbin       \
                                           /usr/bin        \
                                           /sbin           \
                                           /bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#ripgrep 
export FZF_DEFAULT_COMMAND="rg --files --hidden"

#change tmux session dir to current working dir
function tcwd {
    tmux command-prompt "attach -c \"#{pane_current_path}\""
 }
#attach or create main tmux session - unfortunately broken as of tmux 3.2
#function tmain {
#    tmux new -A -s tm_main
#}

    
function bt_off {
    bluetoothctl power off
}
function bt_b {
    bluetoothctl power on && bluetoothctl connect 78:2B:64:13:12:F8
}
function bt_a {
    bluetoothctl power on && bluetoothctl connect 00:10:61:13:52:5E
}

function rgvim {
    choice=$(rg -il "$*" | fzf -0 -1 --ansi --preview "cat {} | rg --color=ansi -i \"$*\" --context 3")
    if [ $choice ]
    then
        lc=$(echo "$*" | tr '[:upper:]' '[:lower:]')
        nvim "+/""$lc" $choice

    fi
}

gdb-tmux() {
    local id="$(tmux split-pane -hPF "#D" "tail -f /dev/null")"
    tmux last-pane
    local tty="$(tmux display-message -p -t "$id" '#{pane_tty}')"
    gdb -ex "dashboard -output $tty" "$@"
    tmux kill-pane -t "$id"
}

export PATH="$HOME/.poetry/bin:$PATH"
