#!/bin/bash

# Check if Neovim is installed
is_installed=$(command -v nvim 2>&1 >/dev/null; echo $?)

# Check if neovim is >= 0.8
if [[ $is_installed -eq 0 ]]; then
    nvim_version=$(nvim --version | head -n 1 | cut -d ' ' -f 2)
    nvim_major=$(echo $nvim_version | cut -d '.' -f 1)
    nvim_minor=$(echo $nvim_version | cut -d '.' -f 2)
    if [[ $nvim_major -lt 0 || $nvim_minor -lt 8 ]]; then
        is_installed=1
    fi
fi

if [[ $is_installed -eq 1 ]]; then
    echo "Neovim >= 0.8 is required"

    echo "You can install it with:"
    echo "  sudo add-apt-repository ppa:neovim-ppa/unstable"
    echo "  sudo apt update"
    echo "  sudo apt install neovim"

    echo "Or"
    echo "  sudo snap install nvim"

    exit 1
fi

# Ensure npm installed
if ! command -v npm &> /dev/null
then
    echo "npm could not be found"

    echo "You can install it with:"
    echo "  sudo apt install npm"

    exit 1
fi

echo "Neovim is installed"
echo "Open Neovim (ignore errors on first run) and run :PackerSync"
