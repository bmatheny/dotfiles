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
Take the below and drop it into a file, then run it

<pre><code>#!/bin/sh

# Run it as curl
TMP_FILE=~/tmp/bmatheny-dotfiles.tar.gz

HAVE_WGET=`wget --version 2>&1 >/dev/null`
if [[ $? -ne 0 ]]; then
        echo "# Install wget";
        echo "yum install wget";
	exit;
fi

HAVE_UNZIP=`unzip -version 2>&1 >/dev/null`
if [[ $? -ne 0 ]]; then
	echo "# Install unzip";
	echo "yum install unzip";
	exit;
fi

if [[ ! -d tmp ]]; then
        mkdir tmp;
fi

if [[ ! -d src ]]; then
        mkdir src;
fi

if [[ ! -d bin ]]; then
        mkdir bin;
fi

if [ ! -L "bin/ec2-api-tools" ]; then
	cd bin;
	wget -q http://s3.amazonaws.com/ec2-downloads/ec2-api-tools.zip
	unzip -q ec2-api-tools.zip
	ln -s ec2-api-tools-* ec2-api-tools
	rm -f ec2-api-tools.zip
	cd $HOME;
fi

if [[ -f ${TMP_FILE} ]]; then
        rm -f ${TMP_FILE};
fi

wget --no-check-certificate -q -O $TMP_FILE http://github.com/bmatheny/dotfiles/tarball/master
cd src
tar -xzf ${TMP_FILE}
cd bmatheny-dot*
git submodule update --init --recursive
cd $HOME
rm -f ${TMP_FILE}

echo "# Install zsh, screen, ruby"
echo "yum install zsh screen ruby"
echo ""

echo "# Change shell to zsh"
echo "chsh -s /bin/zsh"
echo ""

echo "# Install home dir files"
echo "cd src/bmatheny-dotfiles* && rake install"
echo "gem install jekyll RedCloth redcarpet jeweler github-markup"
</code></pre>
