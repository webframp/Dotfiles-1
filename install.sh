#!/usr/bin/env bash

command_exists() {
    type "$1" > /dev/null 2>&1
}

echo "Installing dotfiles"

echo "Initializing submodule(s)"
git submodule update --init --recursive

source install/link.sh

source install/git.sh

# only perform macOS-specific install
if [ "$(uname)" == "Darwin" ]; then
    echo -e "\n\nRunning on OSX"

    source install/brew.sh
    
    source install/osx.sh

    source install/nvim.sh # TODO: check not for Darwin OS only

    # source install/tmux.sh # TODO: check not for Darwin OS only

    source ./install/nvm.sh # TODO: check not for Darwin OS only

    # create a backup of the original nginx.conf
    if [ -f /usr/local/etc/nginx/nginx.conf ]; then
        mv /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf.original
    fi

    ln -s ~/.dotfiles/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf

    # symlink the code.dev from dotfiles
    ln -s ~/.dotfiles/nginx/code.dev /usr/local/etc/nginx/sites-enabled/code.dev
fi

echo "creating vim directories"
mkdir -p ~/.vim-tmp

if ! command_exists zsh; then
    echo "zsh not found. Please install and then re-run installation scripts"
    exit 1
elif ! [[ $SHELL =~ .*zsh.* ]]; then
    echo "Configuring zsh as default shell"
    chsh -s $(which zsh)
fi

YELLOW="$(tput setaf 3)"
NORMAL="$(tput sgr0)"

# if [ "$(uname)" == "Darwin" ]; then
#     toilet -f future -F border ' Remember to install the vim pligins ! ' -t && toilet -f smmono9 '   ~/$ vim +PlugInstall' -t
# else
    printf "💡 ${YELLOW}Remember to install the vim pligins!${NORMAL} vim +PlugInstall!\n"
# fi

source install/omz.sh

echo "Done. Restart your Terminal."
