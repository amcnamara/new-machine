# --- ZedShell --- #

# Allow inline comments
setopt interactivecomments

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

# When piping X always force emacs to open in a terminal (no-window)
alias emacsemacs=$(which emacs)
alias emacsd="emacsemacs --daemon"
alias emacs="emacsclient -nw"
# Set default editor for git, git-blog, etc
export EDITOR=emacs

# Add git-blog scripts to path
export PATH=$WORKSPACE/git-blog/bin:$PATH

# Set java home for emacs' jdee
#export JAVA_HOME=$(/usr/libexec/java_home)

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

alias git-report='f() {
  git ${@} log --shortstat --no-merges --pretty="format:#%H, %aN, %ae, %cd, " --date="format:%Y-%m-%d" |
  # Mixing shortstat (to pull file changes, insertion, deletion counts) with pretty print means we need to do lots of cleanup
  gsed -E "s/^ //" |
  tr -d "\n" |
  # Insert a newline between each record by replacing the placeholder # character in the pretty-print output
  tr "#" "\n" |
  # Scrape out values for file changes, insertions, and deletions (until pretty-print supports these fields)
  gsed -E "s/([[:digit:]]+) files? changed, ([[:digit:]]+) insertions?\(\+\), ([[:digit:]]+) deletion.*/\1, \2, \3/; \
           s/([[:digit:]]+) files? changed, ([[:digit:]]+) insertion.*/\1, \2, 0/; \
           s/([[:digit:]]+) files? changed, ([[:digit:]]+) deletion.*/\1, 0, \2/" |
  # Trim whitespace at start of each line, and prepend repo name into the first column
  gsed -E "/^ *$/d; s/^/$(basename `git ${@} rev-parse --show-toplevel`), /"
}; f'

alias git-report-generate-all='f() {
  local repos=$(find $1 -d 1)
  local total=$(echo $repos | wc -l | tr -d "[:space:]")
  local count=1

  echo $repos | while read -r repo _; do
    local repo_basename=$(basename `git -C $repo rev-parse --show-toplevel`)
    echo "[$fg[yellow]$count/$total$reset_color] Pulling new commits for: $(tput bold)$repo_basename$reset_color"
    git -C $repo pull
    echo -n "Generating report... "
    # Generate a report, and inject a newline at the end before writing
    (git-report -C $repo && echo "") > ~/Workspace/reports/$repo_basename.csv
    echo " $fg[green]done$reset_color"
    count=$((count+1))
  done

  echo -n "$fg[cyan]Generating aggregate report...$reset_color"
  # Append all of the reports together into a global report, and add column headers to the first row
  find ~/Workspace/reports/**/*.csv | xargs cat \
    <(echo "REPO, COMMIT HASH, COMMITTER NAME, COMMITTER EMAIL, COMMIT DATE, FILE CHANGE COUNT, INSERTION COUNT, DELETION COUNT") > \
    ~/Workspace/reports/auditboard_report_global.csv
  echo " $fg[green]done$reset_color"
}; f'

# Used to authorize signing keys for Git commits
#
# NOTE: If stuck waiting on a lock, delete the locks via
#       rm ~/.gnupg/{S.keyboxd,public-keys.d/pubring.db.lock}
export GPG_TTY=$(tty)
