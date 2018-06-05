#!/bin/bash
set -x

SCRIPT_PATH=$(dirname $(readlink -f $0))
cd $SCRIPT_PATH

# Install dependencies
sudo apt-add-repository -y ppa:fish-shell/release-2
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt-get install -y curl git vim tmux fish

# Get newest config data
git pull

# Clear out old environment
rm -rf ~/.vim ~/.vimrc ~/.tmux.conf ~/.config/fish ~/.local/share/omf ~/.config/omf ~/.cache/omf

# Initialize Fish
chsh -s /usr/bin/fish
mkdir -p ~/.config/fish

# Initialize Oh My Fish
#curl -L https://get.oh-my.fish > install
#fish install --path=~/.local/share/omf --config=~/.config/omf
#rm install

# Set primary editor to vim in bashrc
sed -i '/export VISUAL/d' ~/.bashrc
echo export VISUAL=vim >> ~/.bashrc
sed -i '/export EDITOR/d' ~/.bashrc
echo export EDITOR=vim >> ~/.bashrc
git config --global core.editor "vim"

# Create Config files
cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf
cp config.fish ~/.config/fish/

# Install Powerline Fonts
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
mkdir ~/.fonts
mv PowerlineSymbols.otf ~/.fonts/
fc-cache -vf ~/.fonts/
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir -p ~/.config/fontconfig/conf.d
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# Install Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install Color Schemes
git clone  https://github.com/flazz/vim-colorschemes.git ~/.vim/bundle/colorschemes
curl https://raw.githubusercontent.com/nightsense/wonka/master/colors/wonka-dark.vim > ~/.vim/bundle/colorschemes/colors/wonka-dark.vim

# Install Airline
git clone https://github.com/vim-airline/vim-airline ~/.vim/bundle/vim-airline
vim -u NONE -c "helptags ~/.vim/bundle/vim-airline/doc" -c q

# Install Airline Themes
git clone https://github.com/vim-airline/vim-airline-themes ~/.vim/bundle/vim-airline-themes
vim -u NONE -c "helptags ~/.vim/bundle/vim-airline-themes/doc" -c q

# Install Tmux Airline
git clone https://github.com/edkolev/tmuxline.vim ~/.vim/bundle/tmuxline.vim
vim -u NONE -c "helptags ~/.vim/bundle/tmuxline.vim/doc" -c q

# Install Fugitive
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
vim -u NONE -c "helptags ~/.vim/bundle/vim-fugitive/doc" -c q

# Install NERDCommenter
git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
vim -u NONE -c "helptags ~/.vim/bundle/nerdcommenter/doc" -c q

git clone --depth=1 https://github.com/vim-syntastic/syntastic.git ~/.vim/bundle/syntastic
vim -u NONE -c "helptags ~/.vim/bundle/syntastic/doc" -c q

