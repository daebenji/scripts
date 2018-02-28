#!/bin/bash
# Init
FILE="/tmp/out.$$"
GREP="/bin/grep"

# check if user or root environment
if [[ $EUID -ne 0 ]]; then
 
   # public key
   mkdir .ssh
   wget https://raw.githubusercontent.com/daebenji/scripts/master/id_rsa_pub -O .ssh/authorized_keys
   
   # bashrc
   https://raw.githubusercontent.com/daebenji/scripts/master/environment/.bashrc_users -O .bashrc
   source .bashrc
   
   # vimrc
   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.vimrc_linux_unix -O .vimrc
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   vim +PluginInstall +qall
   
   exit 0
   
 else
   
   apt update && apt upgrade
   apt install vim git sudo
   
   # add user to sudoers without asking for password
   # echo "<username>    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
   
   # public key
   mkdir .ssh
   wget https://raw.githubusercontent.com/daebenji/scripts/master/id_rsa_pub -O .ssh/authorized_keys
   
   # bashrc
   https://raw.githubusercontent.com/daebenji/scripts/master/environment/.bashrc_root -O .bashrc
   source .bashrc
   
   # vimrc
   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.vimrc_linux_unix -O .vimrc
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   vim +PluginInstall +qall
   exit 0   
fi

