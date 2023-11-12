# MYRC

This little repository contains a few helper scripts and rc files to help me get quickly set up on a new computer/machine.



## SSH'ing

Typically, ssh is the standard way to connect to a machine. First, generate a key

```bash
ssh-keygen -t ed25519 -C "commet"
```

this will ask for a filename to store (just pick something reasonable). you will then need to copy over the `*.pub` part of the ssh file and login should work from there.

To make ssh'ing easier, add something like this to your `~/.ssh/config` file. 

```
Host cedar
  User dboyea
  IgnoreUnknown UseKeychain
  UseKeychain yes
  HostName cedar.alliancecan.ca
  IdentityFile ~/.ssh/id_ed25519_drac
  ForwardX11 yes
  ForwardX11Trusted yes
```

### git ssh

I find using ssh is the easiest authentication method for github.

## Python and other modules

typically, look up what is recommended for use of python

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

add these lines to `.config/nvim/init.vim` so nvim uses vimrc

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
```

run `PlugInstall`, and install pynvim



### language servers and other

`````bash
pip install pynvim, jedi-language-server
`````

`pip install pynvim`



## bashrc

some options and useful convenience functions

```bash
# soma aliases
alias vim=nvim

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ls='ls -hF'
alias lt='ls -ltr'

# slurm helpers
alias sls='squeue -u $USER '
```





## SLURM

Here's a minimal template slurm script

```bash
#!/bin/bash
#SBATCH --job-name=example
#SBATCH --time=00:10:00
#SBATCH --ntasks=1
#SBATCH --mem=4000MB
#SBATCH --output=%J.out
#SBATCH --account=$SLURM_ACCOUNT

set -x # repeat commands debugging
export OMP_NUM_THREADS=$SLURM_NUM_TASKS

# ./run

scontrol show job=$SLURM_JOB_ID # print out report
```

