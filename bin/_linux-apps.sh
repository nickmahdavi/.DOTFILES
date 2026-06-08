#!/bin/bash
# Sourceable helpers for Linux GUI apps. Idempotent: safe to run repeatedly.
# Strategy: apt repos for things that publish one (auto-update via `apt upgrade`),
# Flatpak for the rest (auto-update via `flatpak update`). No re-downloading .debs.

# Wire up official apt repos with signed keyrings. Re-running is a no-op.
setup_apt_repos () {
    sudo install -d -m 0755 /etc/apt/keyrings

    # Google Chrome
    if [ ! -f /etc/apt/keyrings/google-chrome.gpg ]; then
        wget -qO- https://dl.google.com/linux/linux_signing_key.pub \
            | sudo gpg --dearmor -o /etc/apt/keyrings/google-chrome.gpg
    fi
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/google-chrome.gpg] http://dl.google.com/linux/chrome/deb/ stable main" \
        | sudo tee /etc/apt/sources.list.d/google-chrome.list > /dev/null

    # Visual Studio Code
    if [ ! -f /etc/apt/keyrings/packages.microsoft.gpg ]; then
        wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
            | sudo gpg --dearmor -o /etc/apt/keyrings/packages.microsoft.gpg
    fi
    echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" \
        | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

    sudo apt update
    sudo apt install -y google-chrome-stable code
}

# Flatpak apps (auto-update via `flatpak update`). Re-running is a no-op.
install_flatpaks () {
    if ! command -v flatpak > /dev/null; then
        sudo apt install -y flatpak
    fi
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y --noninteractive flathub \
        com.discordapp.Discord \
        md.obsidian.Obsidian \
        org.alacritty.Alacritty
}

# Nerd Font, version-checked so it only downloads when missing.
install_nerd_font () {
    local dest=~/.local/share/fonts/BlexMonoNerdFontMono-Regular.ttf
    if [ -f "$dest" ]; then
        return 0
    fi
    mkdir -p ~/.local/share/fonts
    wget -qO "$dest" \
        "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/IBMPlexMono/Mono/complete/Blex%20Mono%20Nerd%20Font%20Complete%20Mono.ttf"
    fc-cache -f
}
