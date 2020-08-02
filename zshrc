# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#----------------------------------------#
#                  ZSH                   #
#----------------------------------------#

# Opts

unsetopt correct
unsetopt correctall
setopt autocd
setopt extendedglob
setopt HIST_IGNORE_ALL_DUPS
# setopt INC_APPEND_HISTORY
# setopt SHARE_HISTORY
setopt APPEND_HISTORY
# setopt menu_complete

DISABLE_CORRECTION="true"

# Autoload prompt

autoload -U promptinit; promptinit
# prompt pure
# Number of jobs in background
# PROMPT='%(1j.[%j] .)%(?.%F{magenta}.%F{red})${PURE_PROMPT_SYMBOL:-❯}%f '
# One line prompt
# prompt_newline='%666v'
# PROMPT=" $PROMPT"

prompt powerlevel10k

# Completion

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _approximate _prefix
zstyle ':completion:*' expand prefix
zstyle ':completion:*' file-sort access
zstyle ':completion:*' group-name ''
zstyle ':completion:*' insert-unambiguous false
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]} r:|[._-]=** r:|=** l:|=*'
zstyle :compinstall filename '/Users/nicmahd/.zshrc'

autoload -Uz compinit; compinit -u
# End of lines added by compinstall

# History

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

bindkey -v # Vim mode
bindkey "^?" backward-delete-char
export KEYTIMEOUT=1

# Plugins

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Bindings

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

## VARIABLE FILE
if [[ "$OSTYPE" == "linux"* ]]; then
    [ -f ~/.variables ] && source ~/.variables
else
    [ -f ~/.var ] && source ~/.var
fi


#----------------------------------------#
#              ZSH_PLUGINS               #
#----------------------------------------#

# Highlighters

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

typeset -A ZSH_HIGHLIGHT_PATTERNS
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=white,bold,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('rm *' 'fg=white,bg=red')
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf /*' 'fg=green,bold,bg=red')

# ZSH_HIGHLIGHT_STYLES[default]='fg=green' #GREENISH
# ZSH_HIGHLIGHT_STYLES[command]='fg=blue' #BLUE = 027
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=cyan,bold' #117
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=yellow,bold' #121
# ZSH_HIGHLIGHT_STYLES[builtin]='fg=134'
# ZSH_HIGHLIGHT_STYLES[arg0]='fg=027'
# ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'

# source ~/.zsh/purepower

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
