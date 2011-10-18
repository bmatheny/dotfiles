# My oh-my-zsh plugins
export ZSH_CUSTOM=$HOME/.zshplugins

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="pmcgee"

# Set to this to use case-sensitive completion
export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(brew bundler cap gem git github osx rails ruby)

export PATH="/usr/local/bin:$HOME/bin:$HOME/bin/ec2-api-tools/bin:$PATH"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
if [ -f ~/.zshrc.private ]; then
	source ~/.zshrc.private
fi

export PDSH_SSH_ARGS_APPEND="-t -t"
