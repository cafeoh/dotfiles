#!/bin/bash

PREV=`pwd`

sudo apt-get update
sudo apt-get upgrade


cp -rf .* ..

sudo apt-get install git vim exuberant-ctags ack cmake

##### i3-gaps #####
# sudo apt-get install i3
# cd ~
# git clone https://github.com/maestrogerardo/i3-gaps-deb
# cd i3-gaps-deb
# ./i3-gaps-deb
# cd $PREV
# cp -rf .config ../


####   zsh   #####
sudo apt-get install zsh curl
sudo chsh -s `which zsh`
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cp -rf ./oh-my-zsh.sh ../.oh-my-zsh
