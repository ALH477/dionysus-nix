{ config, pkgs, ... }:
{
  # Import dionysus modules
  imports = [ ./modules ];

  # ======================
  # Dionysus Configuration
  # ======================
  dionysus = {
    # Terminal
    alacritty.enable = true;
    
    # Audio Visualizer
    cava.enable = true;
    
    # Widgets
    eww.enable = true;
    
    # Compositor
    hyprland.enable = true;
    
    # System Info
    neofetch.enable = true;
    
    # App Launcher
    rofi.enable = true;
    
    # Status Bar
    waybar.enable = true;
    
    # Shell
    zsh.enable = true;
  };

  # ======================
  # Home Manager Settings
  # ======================
  home = {
    username = "your-username";
    homeDirectory = "/home/your-username";
    stateVersion = "24.11";
    
    packages = with pkgs; [
      # Common dependencies
      git
      curl
      wget
      jq
      bat
      exa
      fzf
      ripgrep
      fd
      tmux
      htop
      btop
      neovim
      firefox
    ];
  };

  programs = {
    home-manager.enable = true;
  };
}
