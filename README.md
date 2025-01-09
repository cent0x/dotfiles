
- verrify if zsh is the shell `echo $SHELL`and  install `zsh` if not  
```
sudo apt update
sudo apt install zsh
```

change bash to zsh
```
chsh -s $(which zsh)
```

- install `tree`, `stow`, `unzip` and `eza` 
```
sudo apt install tree
sudo apt install stow
sudo apt install unzip
sudo apt install eza
```

- install zinit
```
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

- install `fzf`
```
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

- oh-my-posh install
```
sudo apt install unzip
curl -s https://ohmyposh.dev/install.sh | bash -s
```

- add tpm plugin
```
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

- clone the dotfile
```
git clone https://github.com/cent0x/dotfiles.git
```

- create symlink using stow
```
stow ohmy
stow zsh
stow tmux
```
