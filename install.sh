#!/bin/bash

# Define the source directory (where this script is located)
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Define the target config directory
CONFIG_DIR="$HOME/.config"

# Detect OS
OS="$(uname -s)"
echo "Detected OS: $OS"

# Create the config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Helper function to backup and symlink
link_file() {
    local src="$1"
    local dest="$2"

    echo "Setting up $dest..."

    # Check if destination exists
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        # Check if it's already a symlink to the correct location
        # Use readlink standard behavior which works on both Linux and macOS for direct links
        local current_link
        current_link="$(readlink "$dest")"
        
        if [ -L "$dest" ] && [ "$current_link" == "$src" ]; then
            echo "  Already linked correctly."
            return
        fi

        # Backup existing file/directory
        local backup="${dest}.backup.$(date +%Y%m%d%H%M%S)"
        echo "  Backing up existing file to $backup"
        mv "$dest" "$backup"
    fi

    # Create the symlink
    echo "  Linking $src -> $dest"
    ln -s "$src" "$dest"
}

# --- Standard Dotfiles (Cross-Platform) ---

# Zsh
link_file "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"

# Tmux
link_file "$DOTFILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# --- XDG Config Dotfiles (Cross-Platform) ---
# Most modern tools use ~/.config on both Linux and macOS

# Alacritty
link_file "$DOTFILES_DIR/alacritty" "$CONFIG_DIR/alacritty"

# Bat
link_file "$DOTFILES_DIR/bat" "$CONFIG_DIR/bat"

# Direnv
link_file "$DOTFILES_DIR/direnv" "$CONFIG_DIR/direnv"

# Fastfetch
link_file "$DOTFILES_DIR/fastfetch" "$CONFIG_DIR/fastfetch"

# Fish
link_file "$DOTFILES_DIR/fish" "$CONFIG_DIR/fish"

# Ghostty
link_file "$DOTFILES_DIR/ghostty" "$CONFIG_DIR/ghostty"

# Helix
link_file "$DOTFILES_DIR/helix" "$CONFIG_DIR/helix"

# Kitty
link_file "$DOTFILES_DIR/kitty" "$CONFIG_DIR/kitty"

# Neovim
link_file "$DOTFILES_DIR/nvim" "$CONFIG_DIR/nvim"

# Starship (special case: toml file to .config/starship.toml)
link_file "$DOTFILES_DIR/starship.toml" "$CONFIG_DIR/starship.toml"

# Zed
link_file "$DOTFILES_DIR/zed" "$CONFIG_DIR/zed"


# --- macOS Specific Setup ---
if [ "$OS" == "Darwin" ]; then
    echo "--- Running macOS specific setup ---"

    # Rectangle (macOS window manager)
    # Rectangle typically stores config in ~/Library/Preferences/ or Application Support
    # But if you are syncing a config file to manually load/reference:
    if [ -d "$DOTFILES_DIR/rectangle" ]; then
         mkdir -p "$CONFIG_DIR/rectangle"
         link_file "$DOTFILES_DIR/rectangle/RectangleConfig.json" "$CONFIG_DIR/rectangle/RectangleConfig.json"
    fi

    # Nix-Darwin
    # Usually requires bootstrapping, but we can link the config if it exists
    if [ -d "$DOTFILES_DIR/darwin" ]; then
        # Often mapped to ~/.nixpkgs/darwin-configuration.nix or ~/.config/nix-darwin
        # Adjust target based on your specific nix-darwin setup. 
        # Defaulting to ~/.config/darwin for safety.
        link_file "$DOTFILES_DIR/darwin" "$CONFIG_DIR/darwin"
    fi

else
    echo "--- Skipping macOS specific setup (Rectangle, Darwin) ---"
fi


# --- Linux Specific Setup ---
if [ "$OS" == "Linux" ]; then
    echo "--- Running Linux specific setup ---"
    
    # Add any Linux-only config links here if you have them later
    # Example: i3, sway, rofi, etc.
fi

# --- Nix Home Manager (Cross-Platform) ---

if [ -d "$DOTFILES_DIR/home-manager" ]; then
     link_file "$DOTFILES_DIR/home-manager" "$CONFIG_DIR/home-manager"
fi

if [ -d "$DOTFILES_DIR/nix" ]; then
     link_file "$DOTFILES_DIR/nix" "$CONFIG_DIR/nix"
fi


echo "Done! Dotfiles installation complete."
echo "You may need to restart your shell or applications to see changes."
