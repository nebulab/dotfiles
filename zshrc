# modify the prompt to contain git branch name if applicable
git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo " %{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}"
  fi
}
setopt promptsubst
export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '

# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
autoload -U compinit
compinit

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc
export CLICOLOR=1

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# awesome cd movements from zshkit
setopt autocd autopushd pushdminus pushdsilent pushdtohome cdablevars
DIRSTACKSIZE=5

# Enable extended globbing
setopt extendedglob

# Allow [ or ] whereever you want
unsetopt nomatch

bindkey -e
bindkey "[D" beginning-of-line
bindkey "[C" end-of-line

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# load rbenv if available
if which rbenv &>/dev/null ; then
  eval "$(rbenv init - --no-rehash)"
fi

# https://github.com/sstephenson/ruby-build/wiki#trouble-with-irb-or-pry
RUBY_CONFIGURE_OPTS=--with-readline-dir="$(brew --prefix readline)"

# load thoughtbot/dotfiles scripts
export PATH="$HOME/.bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

# Syntax Highlighting
if [ -e $HOME/.zsh/plugins/zsh-syntax-highlighting ]; then
  source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Setup History Suggestions
if [ -e $HOME/.zsh/plugins/zsh-history-substring-search ]; then
  source ~/.zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  zmodload zsh/terminfo
  # bind UP and DOWN arrow keys
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
fi

# Setup Autosuggestions
if [ -e $HOME/.zsh/plugins/zsh-autosuggestions ]; then
  source ~/.zsh/plugins/zsh-autosuggestions/autosuggestions.zsh
  # Enable autosuggestions automatically
  zle-line-init() {
      zle autosuggest-start
  }
  zle -N zle-line-init
  # use ctrl+t to toggle autosuggestions(hopefully this wont be needed as
  # zsh-autosuggestions is designed to be unobtrusive)
  bindkey '^T' autosuggest-toggle
fi

# Aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# Local config
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
