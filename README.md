# MYRC

This little repository contains a few helper scripts and rc files to help me get quickly set up on a new computer/machine.

## SSH'ing

We all love and adore ssh (or we have to before it has consumed the internet alive).



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

If you want to launch e.g. a jupyter server, you will need to forward the port over ssh.

```bash
ssh -L local_port:destination_server_ip:remote_port ssh_server_hostname
```

### RSync

Sometimes it is helpful to rsync to transfer files between servers.



```bash
rsync -av -e "ssh -p 2233 -i ~/.ssh/sangiovese" orbit1 dboyea@sangiovese.phys.uvic.ca:/arc7/home/dboyea
```

Then we can shasum to determine any differences `sha256sum <(find . -type f -exec sha256sum {} \; | sort)`

##  Github

I like accessing github through ssh keys.

```bash
git config --global user.name "Daniel Boyea"
git config --global user.email "aeyobd@github.com"
```



Github has a nice little website to set these up. https://docs.github.com/en/authentication/connecting-to-github-with-ssh



```bash
 ssh-keygen -t ed25519 -C "aeyobd@gmail.com"
```



## Code modules

typically, look up what is recommended for use of python, julia, etc. 

# bashrc

some options and useful convenience functions

```bash
# soma aliases

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias ls='ls -hF'
alias lt='ls -ltr'

# slurm helpers
alias sls='squeue -u $USER -o "%12i%36j%10M%20S"'              alias swatch='watch -t squeue -u $USER -o "%12i%36j%10M%20S"'
# alias python='python3'
# alias ipython='ipython --profile=daniel'
# alias vim='nvim'
# alias vi='vi'

# path
export PATH=$PATH:~/.local/bin


set -o vi # sets vim-like shell 



# supercomputer
export SLURM_ACCOUNT=<>
export OMP_NUM_THREADS=1
```



# neoVIM

Why Neovim? Most vim installations do not have the python option, so need to install anyways for better autocomplete. Also lua and in-buit language servers make coding much nicer



to install nvim

```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage ~/.local/bin/nvim
```

Aside. Sometimes GLIBC might not be installed where we think or be the version nvim requires (see https://github.com/neovim/neovim-releases/releases for older releases). 

next, copy over my  vimrc and vim files

```
cp vimrc ~/.vimrc
cp -r vim ~/.vim
```

install [VimPlug](https://github.com/junegunn/vim-plug) for neovim

```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

### language servers and other

`````bash
pip install pynvim, jedi-language-server
`````

add these lines to `.config/nvim/init.vim` so nvim uses vimrc

```vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
```

run :`PlugInstall`, and finally setup copilot with `:Copilot setup`.





# SLURM

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

# ./run # or whichever script you would like to run

scontrol show job $SLURM_JOB_ID # print out report
```

Finally, it is helpful to check usage with `seff JOB-ID`, or some systems use `sacct --format="CPUTime,MaxRSS,Elapsed"`. 

To run interactive sessions, some systems have `sinteractive` or on others `salloc --account $SLURM_ACCOUNT`

For the dwarfs project, I find that wrapper scripts for the submission saves many redundant codes. Just wrap something like the above in a bash script piped into sbatch and allow arguments like memory to pass through.

# Latex workflow

### Zotero

Zotero allows for easy citation management. I like it since it's free and fairly easy to use. New version is very nice

### Better BibTex

Formula for citation keys: `authors(max=1).lower || (authors(max=3) ? authIni(n=1, sep="") : auth.lower + "+") + shortyear`.  (see https://retorque.re/zotero-better-bibtex/citing/ )'

Right click library name, export..., betterbibtex.

### Latex

Use overleaf. Easiest way to share a live document. Can also git commit draft versions as well as we go.

# Julia

Can download juliaup from the project website 

```
curl -fsSL https://install.julialang.org | sh
```

Note that julia packages can take a lot of space, so on clusters it may be helpful to store the packges not in the home directory, e.g. by adding this to the bash_profile

```
export DATA_DIR=/cosma5/data/durham/dc-boye1/
export JULIA_DEPOT_PATH="$DATA_DIR/.julia:$JULIA_DEPOT_PATH"
export JULIA_LOAD_PATH="$DATA_DIR/.julia:$JULIA_LOAD_PATH"
export JULIA_PROJECT="$DATA_DIR/.julia"
```



I find the syntax to the plots.jl package most beautaful and well-maintaned. Pythonplot is the only one  with acceptable control for me, but import Arya.jl to set a good style.



## Pluto on the supercomputer

I find it helpful to first set up a launcher script for pluto, e.g.

```
#!/bin/bash
julia -e "import Pluto; Pluto.run(port=1235, require_secret_for_access=false, launch_browser=false)"
```

But if running through a compute node, first determine the node the job is on 

```
echo $SLURM_JOB_NODELIST
```

then ssh from the login node to the compute node e.g.

``` 
ssh -L 1235:localhost:1235 <node>
```

where <node> is the server or computer node (from above)



### Local registry

To enable use of pluto's default package manager and reproducible environments,  we can use [LocalRegistry.jl](https://github.com/GunnarFarneback/LocalRegistry.jl?tab=readme-ov-file)  to help with versioning.

The procedure we need is as follows

- When setting up a new environment, use `pkg"registry add git@github.com:aeyobd/RegularRegistry"` (done once)
- Note may want to add JULIA_PKG_USE_CLI_GIT=true to environment
- We can now add Arya.jl and update as new versions are added
- We do not even need LocalRegistry installed except to register new versions!
- To register a new version, make the package dir clean, update the version in Project.toml, then import LocalRegistry; register() in the package directory. New version now available for use!



# File types

Notes so that I keep filetypes to a minimum.

## Configuration & human readable

Julia included [TOML](https://toml.io/en/v1.0.0) in the [standard library](https://docs.julialang.org/en/v1/stdlib/TOML/). I think this is excellent, intuitive, and a standard solution to human-readable data and config files.

## Tables: FITS

FITS does not have the greatest support in julia yet, however is excellent for tabular data as is binary or ascii and can store header data. However, fits is more challenging to read as a human. Use TOML for otherwise...

## Large (simulation) data: HDF5

Great for multidimensional, efficient binary data
