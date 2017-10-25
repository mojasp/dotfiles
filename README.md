# dotfiles

init.vim is the neovim init file, to be placed in .config/nvim/  
tmux.conf is the tmux configuration file, to be placed inside the home-directory as .tmux.conf

Vim Plugins that need some additional installation steps are:
* [vim-plug](https://github.com/junegunn/vim-plug)
* fzf.vim
* ack.vim (need to install thesilversearcher(ag) package via package manager)
* YouCompleteMe 
* solarized, need to set the terminal colorscheme too, i think i used [dircolors-solarized](https://github.com/seebi/dircolors-solarized)

gdbconfig/init and gdbconfig/alias files are .gitconfig files, to be placed in ~/.gitconfig.d/ and used in conjunction with (gdbdashboard)[https://github.com/cyrus-and/gdb-dashboard]  
You need to install pygments for the syntax-highlighting to work: pip3 install pygments

A more detailed installation manual will follow once i need to setup my environment the next time

