# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Load completions
autoload -Uz compinit && compinit

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^r' sk-select-history

bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias vim='nvim'
alias c='clear'
alias git-reinit="~/bin/git-reinit.sh"
alias dcup="docker-compose up -d"
alias dcupb="docker-compose up -d --build"
alias dcd="docker-compose down --volumes --remove-orphans"
alias ds='docker ps --filter "name=$(basename $(pwd))" --format "{{.ID}}" | xargs -r docker stop'
alias cpcnt="xclip -sel c <"
alias please="sudo"
alias ramon_suge="echo da"
alias ramon_da-i_sa_mearga="yarn dev"
alias ramon_pleaca="exit"
alias nvim="NVIM_APPNAME=lazyvim nvim"
alias vim="nvim"

# Tmux shortcuts
alias tl="tmux list-session"
alias ta="tmux attach-session -t"
alias tn="tmux new-session -s"
alias tx="tmux kill-session"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#Initialize Skim Path
export PATH="$HOME/.cargo/bin:$PATH"

# Shell integrations
function sk-select-history() {
  BUFFER=$(fc -l -n 1 | sk --ansi | sed 's/^[0-9]\+ *//')
  CURSOR=$#BUFFER
  zle redisplay
}

zle -N sk-select-history

# Source Git aliases
if [ -f ~/zsh/git-aliases.zsh ]; then
  source ~/zsh/git-aliases.zsh
fi

export PATH="$HOME/bin:$PATH"
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="/usr/local/bin:$PATH"

# Created by `pipx` on 2024-10-23 09:01:16
export PATH="$PATH:/home/paul/.local/bin"
export PATH="/home/linuxbrew/.linuxbrew/opt/node@22/bin:$PATH"

#neovim
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"

#Scripts

#Prepare development script
alias fordino-dev='
if [ -z "$TMUX" ]; then
  tmux new-session -d -s main -c ~/Documents/Github/fordino/fordino-frontend
  tmux send-keys -t main "yarn dev" Enter
  tmux new-window -t main -c ~/Documents/Github/fordino/fordino-node-backend
  tmux attach-session -t main
else
  tmux rename-session main 2>/dev/null
  tmux send-keys -t main "cd ~/Documents/Github/fordino/fordino-frontend && yarn dev" Enter
  tmux new-window -t main -c ~/Documents/Github/fordino/fordino-node-backend
fi
'
alias gdlb="git fetch --prune && git branch -vv | awk '/: gone]/{print \$1}' | xargs -r git branch -d"


