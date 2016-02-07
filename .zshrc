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
autoload -U predict-on	# 先行予測機能
setopt auto_cd 		# ディレクトリ名だけでcd
setopt auto_pushd	# cdの度にpushd
compinit		# 補完有効
predict-on		# 先行予測機能

## powerline
export PATH=$PATH:~/Library/Python/2.7/bin
powerline-daemon -q
. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
