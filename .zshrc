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
## powerline
export PATH=$PATH:~/Library/Python/2.7/bin
powerline-daemon -q
. ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
