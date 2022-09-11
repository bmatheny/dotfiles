# Customization

This project uses chezmoi for dotfiles management. As such I try to follow
chezmoi conventions.

The configuration template (`.chezmoi.toml.tmpl`) should get copied into
`~/.config/chezmoi/chezmoi.toml` where you can fill out configuration values.
Things should work if you do nothing. Intent of variables are outlined below.

## Variables

* `data.ssh.configs` - Location where SSH configurations including keys can be found.
    * If `$HOME` is found in string, it will be replaced with home directory
    * SSH configuration will include files `$data.ssh.configs/config.d/*`
* `data.ssh.keys` - Array of private keys that should be copied into `~/.ssh/`
    * Note: File will be copied from `$data.ssh.configs/$data.ssh.keys`

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

# Installation

Look at `config.sh`

# TODO items

* Could move SSH configs (private keys) into 1password or something similar
