# Neovim as a PDE

## Dependencies

- [Neovim](https://neovim.io/) (>= 0.8.0)

```bash
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim
```

Or
```bash
sudo snap install nvim"
```

- [Node.js](https://nodejs.org/) (>= 12.0.0)

```bash
sudo apt install nodejs
```

- [NPM](https://www.npmjs.com/) (>= 6.0.0)

```bash
sudo apt install npm
```

- [Golang](https://golang.org/) (>= 1.13.0)

```bash
sudo apt install golang
```

## Installation

Clone this repo to ~/.config/nvim

```bash
git clone git@github.com:nguyentritai2906/nvim.git ~/.config/nvim
```

Open Neovim (ignore errors on first run) and run

```vim
:PackerSync
```
