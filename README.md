# Customization

This project uses chezmoi for dotfiles management. As such I try to follow
chezmoi conventions.

The configuration template (`.chezmoi.toml.tmpl`) should get copied into
`~/.config/chezmoi/chezmoi.toml` where you can fill out configuration values.
Things should work if you do nothing. Intent of variables are outlined below.

## environment variables

* `ASK=y` before initialization in order to get prompted for some variables

## chezmoi Variables

* `data.git.name` - Your name
* `data.git.email` - Your email address
* `data.ssh.configs` - Location where SSH configurations including keys can be found.
    * If `$HOME` is found in string, it will be replaced with home directory
    * SSH configuration will include files `$data.ssh.configs/config.d/*`
* `data.ssh.keys` - Array of private keys that should be copied into `~/.ssh/`
    * Note: File will be copied from `$data.ssh.configs/$data.ssh.keys`

## vim

If you would like to add things to your vim configuration the best place to do
it is...

## zsh

Put customizations in `~/.zsh.before` or `~/.zsh.after`, these will be sourced
before and after other dotfiles included with this project. If you want a custom
theme put it in `~/.zsh.prompts` and create a `~/.zsh.after/prompt.zsh` with a
single line like `prompt "pname"` assuming you put your custom prompt as
`~/.zsh.prompts/prompt_pname_setup`.

If you don't have much going on, just drop any changes you want in
`~/.zshrc.private`j.

# How chezmoi is used

## Externals

A variety of code and configs are sourced from github repositories. Take a look
at `.chezmoiexternal.toml`.

## Scripts

There are a number of scripts for managing parts of the repository and your
dotfiles. These are not very complex. They are all tempaltes, primarily
because they are run once scripts that track the hash of repo files and run
again if the hash is updated.

* `run_once_after_prezto` - Installs prezto the first time it is needed, also creates symlinks to files like `~/.zpreztorc` if the file hash changes
* `run_once_after_ssh` - Installs private keys into your `.ssh/` directory, or if they change
* `run_once_vim_plugins` - Installs vim plugins anytime `.vim/plug.vim` changes

## Templates

# Installation

Look at `install.sh`. This is old and needs to be updated. I'm hoping this will all be handled via the normal chezmoi flow.

# TODO items

* Could move SSH configs (private keys) into 1password or something similar
* Make prezto, git, vim configurations not depend on my stuff; allow them to be extended
    * For gems, homebrew, etc look at my own file but allow it to be extended as well
    * Update those scripts to be templates that get the hash of files (mine and user)
* Read TODO items in scripts
* Document relationship between scripts. When do they execute? On a first run, what executes and in what order? In a 'normal' run, what executes and in what order?
* Handle HTTP/HTTP proxy early
* Linux support
* xcode install/select support for macos
