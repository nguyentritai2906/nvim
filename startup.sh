#!/bin/bash

# Check if neovim is >= 0.8
if [ "$(nvim --version | head -n 1 | cut -d ' ' -f 2 | cut -d '.' -f 2)" -lt 8 ]; then
    echo "Neovim >= 0.8 is required"
    exit 1
fi

# Ensure npm installed
if ! command -v npm &> /dev/null
then
    echo "npm could not be found"
    exit
fi
#
# Install Packer Nvim
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.Nvim

