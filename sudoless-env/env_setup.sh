#!/bin/bash

set -x

SCRIPT_PATH=$(dirname $(readlink -f $0))
cd $SCRIPT_PATH

# Clear out old environment
rm -rf ~/.vim ~/.vimrc ~/.tmux.conf

# Create config files
cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf

# Set primary editor to vim in git
git config --global core.editor "vim"

# Install powerline fonts
git clone https://github.com/powerline/fonts
bash fonts/install.sh
sudo rm -rf fonts

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install colorschemes
git clone  https://github.com/flazz/vim-colorschemes.git ~/.vim/bundle/colorschemes
curl https://raw.githubusercontent.com/nightsense/wonka/master/colors/wonka-dark.vim > ~/.vim/bundle/colorschemes/colors/wonka-dark.vim

# Install airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
vim -u NONE -c "helptags ~/.vim/bundle/vim-airline/doc" -c q

# Install airline-themes
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
vim -u NONE -c "helptags ~/.vim/bundle/vim-airline-themes/doc" -c q

# Install tmuxline
git clone https://github.com/edkolev/tmuxline.vim ~/.vim/bundle/tmuxline.vim
vim -u NONE -c "helptags ~/.vim/bundle/tmuxline.vim/doc" -c q

# Install fugitive
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
vim -u NONE -c "helptags ~/.vim/bundle/vim-fugitive/doc" -c q

# Install nerdcommenter
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
vim -u NONE -c "helptags ~/.vim/bundle/nerdcommenter/doc" -c q

# Install syntastic
git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic
vim -u NONE -c "helptags ~/.vim/bundle/syntastic/doc" -c q

# Install easymotion
git clone https://github.com/easymotion/vim-easymotion ~/.vim/bundle/vim-easymotion
vim -u NONE -c "helptags ~/.vim/bundle/vim-easymotion/doc" -c q

# Logout to reset terminal
gnome-session-quit --force
