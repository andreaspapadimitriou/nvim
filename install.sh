#!/bin/bash

# Install unzip
if ! command -v unzip &>/dev/null; then
    echo "unzip could not be found, installing"
    sudo apt install unzip -y
fi

# Install bat
if ! command -v bat &>/dev/null; then
    echo "bat could not be found, installing"
    sudo apt install bat -y
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat
    mkdir -p "$(bat --config-dir)/themes"
    #wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
    #wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
    #wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
    wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme
    bat cache --build
    echo "--theme 'Catppuccin Mocha'" >"$HOME/.config/bat/config"
fi

if [ ! -d "${HOME}/.nvm/.git" ]; then
    echo "NVM not installed, installing"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
    echo "If 'nvm install 18' fails copy NVM config from profile file to bashrc"
    nvm install 18
    # The corepack enable command allows you to manage and use package managers like
    # Yarn and pnpm without installing them globally. 
    # corepack enable
fi

# TODO add fzf installation