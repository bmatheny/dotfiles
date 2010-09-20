## Code
Take the below and drop it into a file, then run it

<pre><code>#!/bin/sh

# Run it as curl
TMP_FILE=~/tmp/bmatheny-dotfiles.tar.gz

HAVE_WGET=`wget --version 2>&1 >/dev/null`
if [[ $? -ne 0 ]]; then
        echo "# Install wget";
        echo "yum install wget";
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

if [[ -f ${TMP_FILE} ]]; then
        rm -f ${TMP_FILE};
fi

wget -q -O $TMP_FILE http://github.com/bmatheny/dotfiles/tarball/master
cd src
tar -xzf ${TMP_FILE}
cd bmatheny-dot*
cd .oh-my-zsh
wget -q -O oh-my-zsh.tar.gz http://github.com/bmatheny/oh-my-zsh/tarball/master
tar --strip-components 1 -xzf oh-my-zsh.tar.gz
cd $HOME
rm -f ${TMP_FILE}

echo "# Install zsh, screen, ruby"
echo "yum install zsh screen ruby"
echo ""

echo "# Change shell to zsh"
echo "chsh -s /bin/zsh"
echo ""

echo "# Install home dir files"
echo "cd src/bmathen-dotfiles* && rake install"
</code></pre>
