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
   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.bashrc_users -O .bashrc
   source .bashrc

   # .profile
   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/root_profile.txt -O ~/profile
   source ~/.profile
   
   # vimrc
   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.vimrc_linux_unix -O .vimrc
   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   vim +PluginInstall +qall
   
   exit 0

else
   
   if [[ -f /etc/debian_version ]]; then 
	   apt update && apt upgrade 
	   apt install vim git sudo 
	   
	   # add user to sudoers without asking for password
   	   # echo "<username>    ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
 
           # public key
   	   mkdir .ssh
   	   wget https://raw.githubusercontent.com/daebenji/scripts/master/id_rsa_pub -O .ssh/authorized_keys
   	   
   	   # .bashrc
   	   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.bashrc_root -O /root/.bashrc
   	   source /root/.bashrc
   	   
   	   # .profile
   	   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/root_profile.txt -O /root/.profile
   	   source /root/.profile
   	   
   	   # .vimrc
   	   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.vimrc_linux_unix -O .vimrc
   	   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   	   vim +PluginInstall +qall
   	   exit 0   
   else
	   pacman -Suy
	   pacman -S vim git
           # public key
   	   mkdir .ssh
   	   wget https://raw.githubusercontent.com/daebenji/scripts/master/id_rsa_pub -O .ssh/authorized_keys
   	   
   	   # .bashrc
   	   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.bashrc_root -O /root/.bashrc
   	   source /root/.bashrc
   	   
   	   # .profile
   	   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/root_profile.txt -O /root/.profile
   	   source /root/.profile
	   
	   # gruvbox
	   if [[ -d /usr/share/vim/vim81/ ]]; then
	     wget https://raw.githubusercontent.com/daebenji/gruvbox/master/colors/gruvbox.vim -O /usr/share/vim/vim81/colors/gruvbox.vim
	   fi	   
	   
	   if [[ -d /usr/share/vim/vim80/ ]]; then
	     wget https://raw.githubusercontent.com/daebenji/gruvbox/master/colors/gruvbox.vim -O /usr/share/vim/vim80/colors/gruvbox.vim
	   fi
   	   # .vimrc
   	   wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.vimrc_linux_unix -O .vimrc
   	   git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
   	   vim +PluginInstall +qall
	   
	   exit 0   

   fi
fi

