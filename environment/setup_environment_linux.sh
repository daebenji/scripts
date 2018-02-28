apt update && apt upgrade
apt install vim git sudo

# Public Key
mkdir .ssh
wget https://raw.githubusercontent.com/daebenji/scripts/master/id_rsa_pub -O .ssh/authorized_keys

# Bashrc
wget https://github.com/daebenji/scripts/blob/master/environment/.bashrc_root -O .bashrc
source .bashrc

# vimrc
wget https://raw.githubusercontent.com/daebenji/scripts/master/environment/.vimrc_linux_unix -O .vimrc
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
