# --- ZedShell --- #

# Autocompletion configuration
autoload -U compinit
compinit -C
# Allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD
setopt correctall
# Group matches by their description
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
# Match completions without case sensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Record shell command history
export HISTSIZE=50000
export HISTFILE="$HOME/.zsh_history"
export SAVEHIST=$HISTSIZE
setopt hist_ignore_all_dups
# Commands with preceeding space will not be logged
setopt hist_ignore_space

# Load prompt colors
autoload -U colors
colors
# Customized pretty-prompt
export PROMPT="%{$fg[blue]%}[%{$reset_color%}%(!.%{$fg[red]%}root%{$reset_color%}.%n)%{$fg[blue]%}]%{$reset_color%} > "
export RPROMPT="%{$fg[yellow]%}%~%{$reset_color%}"


# --- Credentials --- #

# export HOMEBREW_GITHUB_API_TOKEN
# export ...     
if [[ -e .tokensrc ]]; then
  source .tokensrc
fi


# --- Environment --- #

export WORKSPACE=~/Workspace

# General shorthand and mis-typed stuff
alias l="ls"
alias g="grep"

# When piping X always force emacs to open in a terminal (no-window)
alias emacsemacs=$(which emacs)
alias emacsd="emacsemacs --daemon"
alias emacs="emacsclient -nw"
# Set default editor for git, git-blog, etc
export EDITOR=emacs

# Add git-blog scripts to path
export PATH=$WORKSPACE/git-blog/bin:$PATH

# Set java home for emacs' jdee
export JAVA_HOME=$(/usr/libexec/java_home)

# Add cask binaries to path
export PATH=~/.cask/bin:$PATH

# Add go binaries to path
export PATH=~/go/bin:$PATH

# Use tldr man pages, when possible
alias manman=$(which man)
alias man='f() {
  if [[ $# > 1 ]] || ! type tldr >/dev/null; then
    man $@
  elif tldr $1 >/dev/null; then
    tldr $1
  else
    man $1
  fi
}; f'
