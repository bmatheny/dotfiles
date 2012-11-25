# My oh-my-zsh plugins
export ZSH_CUSTOM=$HOME/.zshplugins

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="blinks_blake"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler gem git github osx redis-cli rbenv ssh-agent)

export PATH="/usr/local/bin:$HOME/bin:$PATH"

# Customize to your needs...
if [ -f ~/.zshrc.private ]; then
	source ~/.zshrc.private
fi

source $ZSH/oh-my-zsh.sh

zstyle :omz:plugins:ssh-agent github_rsa id_rsa
