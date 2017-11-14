#!/bin/sh

GREEN="$(tput setaf 2)"
NORMAL="$(tput sgr0)"

if test ! $(which brew); then
    echo -e "\n\n${GREEN}Installing homebrew"
    echo "==============================${NORMAL}"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo -e "\n\n${GREEN}Updating homebrew"
    echo "==============================${NORMAL}"
    brew update
fi

echo -e "\n\n${GREEN}Installing homebrew packages"
echo "==============================${NORMAL}"

formulas=(
    # flags should pass through the the `brew list check`
    bash
    # cli tools
    the_silver_searcher
    ack
    fzf
    tree
    fasd
    toilet
    wget
    ctags
    htop
    php-cs-fixer
    python
    python3
    # development server setup
    nginx
    mariadb
    dnsmasq
    # development tools
    git
    hub
    'macvim --with-override-system-vim'
    reattach-to-user-namespace
    # tmux
    zsh
    highlight
    nvm
    z
    markdown
    diff-so-fancy

    # 'grep --with-default-names'
    neovim/neovim/neovim
    # node
    # ripgrep
    # git-standup
    # entr
)

for formula in "${formulas[@]}"; do
    if brew list $formula > /dev/null 2>&1; then
        echo "$formula already installed... skipping."
    else
        brew install $formula
    fi
done
