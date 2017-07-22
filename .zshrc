#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Alias
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias ducks='du -cks * | sort -rn | head -11'

# Customize to your needs...
autoload -U compinit
#autoload -U predict-on
setopt auto_cd
setopt auto_pushd
compinit
#predict-on

# dircolors
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
if [ -f ~/.dircolors ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.dircolors)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.dircolors)
    fi
fi

# sdkman(gvm)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Source-highlight
export LESS='-R'
export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'

# PATH
export PATH=$PATH:/opt/maven/bin
export PATH=$PATH:/opt/activator-dist/bin
export PATH=$PATH:~/Library/Python/2.7/bin

# CDPATH
export CDPATH=.:~

# powerline
function load-powerline() {
    local _plhome
    case ${OSTYPE} in
        darwin*)
	    _plhome="${HOME}/Library/Python/2.7/lib/python/site-packages/powerline"
	    ;;
	linux*)
            _plhome="/usr/lib/python2.7/site-packages/powerline"
	    ;;
    esac
    . ${_plhome}/bindings/zsh/powerline.zsh
}
powerline-daemon -q
load-powerline

# peco history search
function peco-history-selection() {
    local _cmd
    case ${OSTYPE} in
        darwin*)
	    _cmd='tail -r'
	    ;;
	linux*)
            _cmd='tac'
	    ;;
    esac
    BUFFER=`history -n 1 | $_cmd | awk '!a[$0]++' | peco --layout=bottom-up`
    CURSOR=$#BUFFER
    zle reset-prompt
}
zle -N peco-history-selection
bindkey '^R' peco-history-selection

# zplug
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "k4rthik/git-cal", as:command, frozen:1
zplug "tj/n", hook-build:"make install"
zplug "b4b4r07/enhancd", use:init.sh
zplug "mollifier/anyframe", at:4c23cb60

if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
