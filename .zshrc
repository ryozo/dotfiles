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

# Customize to your needs...
autoload -U compinit	# 補完機能
#autoload -U predict-on	# 先行予測機能
setopt auto_cd 		# ディレクトリ名だけでcd
setopt auto_pushd	# cdの度にpushd
compinit		# 補完有効
#predict-on		# 先行予測機能

## dircolors
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

## powerline
powerline-daemon -q
. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh

## sdkman(gvm)
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

## PATH
export PATH=$PATH:/opt/maven/bin
export PATH=$PATH:/opt/activator-dist/bin
export PATH=$PATH:~/Library/Python/2.7/bin
