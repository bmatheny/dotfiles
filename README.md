# What is this?

My unix environment (macOS, Linux) including all dotfiles, software
installation, etc. I spin up new shells somewhat regularly, and it's a huge
hassle to rebuild my environment each time.

This was designed so that anyone can use it, but that's mostly so I don't have a
bunch of things hardcoded. I can't imagine anyone besides me actually using
this, but it could serve as an inspiration for others or just another example
for how to use `chezmoi`.

# Installation

There is an
[install.sh](https://github.com/bmatheny/dotfiles/blob/main/install.sh) script
which you can use to get started. It will install `chezmoi`, which will take
care of everything else.

If you are installing on macOS you shouldn't need to do anything other than
install xcode and CLI tools. If you are installing on Ubuntu I would recommend:

```bash
apt install build-essential procps curl file git zsh
bash <(curl -sL https://gist.githubusercontent.com/bmatheny/f7cef71291d1ea3175b6d9d1bf312a3e/raw/install_ruby_rpi.sh)
```

Assuming you have the appropriate pre-requisites installed, I would recommend
installing as:

```bash
$ ASK=y zsh -c "$(curl -fsLS https://raw.githubusercontent.com/bmatheny/dotfiles/main/install.sh)"
```

Please note all the usual caveats about trusting code from a remote location.

# Basic customization

For day to day tweaks and adjustments, these are the locations to put things.

## Packages

Be sure to put new packages to be installed in `~/.config/bmatheny/Brewfile` and
any new ruby gems to be installed in `~/.config/bmatheny/Gemfile`. These will be
part of a small number of files that will be managed outside of the repository.

## vim

* Plugins
    * After you add or update plugins, although automated, you may want to run the following command in your shell: `vim -es -u ~/.vimrc -i NONE -c "PlugInstall" -c "qa"`
    * Adding new plugins should be done in...
* Scripts/customizations

## zsh

Put customizations in `~/.config/zsh/before` or `~/.config/zsh/after`. These
will be sourced before and after other dotfiles included with this project.

# Chezmoi Customization

This project uses chezmoi for dotfiles management. As such I try to follow
chezmoi conventions.

The configuration template (`.chezmoi.toml.tmpl`) will get expanded when you
first initialize the repository and put in `~/.config/chezmoi/chezmoi.toml`
where you can fill out configuration values. Things should work if you do
nothing (besides git name/email being wrong). Intent of variables are outlined
below.

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

# How chezmoi is used

## Externals

You can find externally sourced software in `.chezmoiexternal.toml`. These are:

* My prezto fork
* plug.vim plugin manager

Although, if you have not installed homebrew and chezmoi, those will be sourced
as well.

## Scripts

There are a number of scripts for managing parts of the repository and your
dotfiles. These are not very complex. They are all tempaltes, primarily
because they are run once scripts that track the hash of repo files and run
again if the hash is updated.

* `run_once_after_prezto` - Installs prezto the first time it is needed, also creates symlinks to files like `~/.zpreztorc` if the file hash changes
* `run_once_after_ssh` - Installs private keys into your `.ssh/` directory, or if they change
* `run_once_vim_plugins` - Installs vim plugins anytime `.vim/plug.vim` changes

## Templates

Some documentation here

# TODO items

* Update docs
    * Document relationship between scripts. When do they execute? On a first run, what executes and in what order? In a 'normal' run, what executes and in what order?
* Read TODO items in scripts

## Ideas

* Handle HTTP/HTTP proxy early
* Linux support
* Could move SSH configs (private keys) into 1password or something similar
* Make prezto, git, vim configurations not depend on my stuff; allow them to be extended
* xcode install/select support for macos: sudo xcodebuild -license accept and something else

# Notes

```
# Modern home directory
find ~/
.cache/          # XDG_CACHE_HOME user-specific non-essential (cached) data files
.config/         # XDG_CONFIG_HOME user-specific configuration files
.local/bin       # In PATH, user-specific executable files
.local/share/    # XDG_DATA_HOME user-specific data files
.local/state/    # XDG_STATE_HOME user-specific state files
```

XDG_STATE_HOME: action history (logs, history, recently used files) and current
state of app that can be used on restart (view, layout, open files, undo
history)
XDG_CACHE_HOME: things not above

What is XDG_DATA_DIRS and XDG_CONFIG_DIRS for?
If defined, XDG_DATA_DIR and XDG_CONFIG_DIR takes precedence over anything in
XDG_{DATA,CONFIG}_DIRS.

XDG_DATA_DIRS if not populated defaults to /usr/local/share:/usr/share
XDG_CONFIG_DIRS if not populated defaults to /etc/xdg/

Search for data files by default would be: .local/share, /usr/local/share, /usr/share
Search for config dirs by default would be: .config/, /etc/xdg
