# Light IDE Installation

## Dependencies

Make sure the [ack](https://github.com/beyondgrep/ack3) and [ctags](https://github.com/universal-ctags/ctags) packages are install on your system. 

Use your distribution's package manager to download the packages. For example, on Arch Linux: 

    $ sudo pacman -S ack ctags

## Installing Plug-ins

Firstly copy the `vimrc` file to your home directory to replace your current `.vimrc` file: 

    $ cp -f ./light-ide/vimrc ~/.vimrc

Make sure the [Vundle](https://github.com/VundleVim/Vundle.vim) plug-in manager is installed on your system. If it's not, run the following commands:

    $ cd ~/.vim
    $ mkdir bundle && cd bundle
    $ git clone https://https://github.com/VundleVim/Vundle.vim Vundle.git
    $ cd ~

Lastly, install the plug-ins by running the following on the command-line:

    $ vim +PluginInstall +qall

Vundle will download the required plug-in repositories to the `~/.vim/plugged` directory. 

You will now be able to use the functionality provided by the light-ide configuration next time you launch Vim!

