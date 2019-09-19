#!/bin/bash

# Read current directory
pwd=$(pwd)

# Create temporary directory
dir=tmp$(date +%s)
echo "Creating temporary directory $dir"
mkdir $dir &&
    echo "Temporary directory $dir created"
    cd $dir &&

# Check essential packages install
echo "Installing essential base packages"
sudo pacman -S --quiet --needed --noconfirm base base-devel &>> packages.log &&
echo "Base packages installed"

# Install pakku
echo "Checking pakku (AUR helper) installation"
if [[ ! $(pacman -Q pakku) ]]; then
    echo "Installing pakku"
    sudo pacman -S --needed --noconfirm --asdeps nim git curl &&
        curl https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=pakku > PKGBUILD &&
        makepkg &&
        for pakku in pakku-*.pkg.tar.xz; do
            sudo pacman --needed --noconfirm -U $pakku &>> packages.log
        done
    echo "Pakku installed"
else
    echo "Pakku already installed"
fi &&

# Install packages
echo "Installing packages from the package list"
pakku -S --needed --noconfirm $(awk 'BEGIN { ORS = " " } { print }' $pwd/package_list) &>> packages.log &&
echo "Packages installed"

# Replace configs
echo "Replacing configs"
mkdir -p ~/.config

rm -f ~/.bashrc
ln -s $pwd/bashrc ~/.bashrc

rm -f ~/.bash_completion
ln -s $pwd/bash_completion ~/.bash_completion

rm -f ~/.config/openbox
ln -s $pwd/openbox ~/.config/openbox

rm -f ~/.config/nvim/init.vim
mkdir -p ~/.config/nvim
ln -s $pwd/init.vim ~/.config/nvim/init.vim
echo "Configs replaced"

echo "Configuring difftool"
echo "[merge]
  tool = vimdiff
[mergetool]
  prompt = true
[mergetool \"vimdiff\"]
  cmd = nvim -d $LOCAL $REMOTE $MERGED -c '$wincmd w' -c 'wincmd J'
[difftool]
  prompt = false
[diff]
  tool = vimdiff" > ~/.gitconfig

# Cleanup
echo "Cleaning up"
cd ..
rm -r $dir
