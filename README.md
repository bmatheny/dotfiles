# Customization

## git

Create a `~/.gitconfig.user` and put the following in it:

    [user]
      name = Your Name
      email = Your Email

Also put any other customizations to git you would like in that file.

## zsh

Put customizations in `~/.zsh.before` or `~/.zsh.after`, these will be sourced
before and after other dotfiles included with this project. If you want a custom
theme put it in `~/.zsh.prompts` and create a `~/.zsh.after/prompt.zsh` with a
single line like `prompt "pname"` assuming you put your custom prompt as
`~/.zsh.prompts/prompt_pname_setup`.

If you don't have much going on, just drop any changes you want in
`~/.zshrc.private`.

## lua

If you want to disable the `LUA_PATH` management just do the following:

    rm -f ~/.lua.zsh && touch ~/.lua.zsh

Otherwise `.zshplugins/lua.zsh` will try to manage your `LUA_PATH` for you. If
you have a directory with lua scripts just export `export LUA_USER=/path/to/dir`
in `~/.zsh.before/some.zsh`.

## Code

Look at `config.sh`
