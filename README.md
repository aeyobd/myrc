# MYRC

This little repository contains a few helper scripts and rc files to help me get quickly set up on a new computer/machine.



## SSH'ing

Typically, ssh is the standard way to connect to a machine. First, generate a key

```bash
ssh-keygen -t ed
```



## neoVIM

to install nvim

```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage .local/bin/nvim
```

next, copy over my  vimrc and vim files

```
cp vimrc ~/.vimrc
cp -r vim ~/.vim
```

install `vimPlug`

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

add these lines to `.config/nvim/init.nvim` so nvim uses vimrc

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
```

and finally run `PlugInstall`.









## bashrc

```
alias vim=nvim

```





