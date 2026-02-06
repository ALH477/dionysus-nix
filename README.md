# Dionysus Dotfiles - Nix Flake

Nix flake for managing dotfiles with home-manager. Published at: https://github.com/ALH477/dionysus-nix

## Structure

```
.
├── flake.nix           # Main flake file
├── home.nix            # Example home-manager configuration
├── modules/            # Nix modules for each application
│   ├── default.nix     # Module list
│   ├── alacritty.nix
│   ├── cava.nix
│   ├── eww.nix
│   ├── hyprland.nix
│   ├── neofetch.nix
│   ├── rofi.nix
│   ├── waybar.nix
│   └── zsh.nix
└── dotfiles/           # Your actual dotfiles
    ├── alacritty/
    ├── cava/
    ├── eww/
    ├── hypr/
    ├── neofetch/
    ├── rofi/
    ├── waybar/
    └── zsh/
```

## Usage

### 1. Add to your system flake

In your `flake.nix`:

```nix
{
  inputs = {
    dionysus.url = "github:ALH477/dionysus-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, dionysus, ... }: {
    homeManagerConfigurations."your-username" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "x86_64-linux"; };
      modules = [
        # Import dionysus modules
        dionysus.homeManagerModules.dionysus

        # Your home.nix
        ./home.nix
      ];
    };
  };
}
```

### 2. Configure in your home.nix

```nix
{ config, pkgs, ... }:
{
  imports = [ dionysus.homeManagerModules.dionysus ];

  # Enable specific dionysus modules you want
  dionysus = {
    alacritty.enable = true;
    cava.enable = true;
    eww.enable = true;
    hyprland.enable = true;
    neofetch.enable = true;
    rofi.enable = true;
    waybar.enable = true;
    zsh.enable = true;
  };

  home = {
    username = "your-username";
    homeDirectory = "/home/your-username";
    stateVersion = "24.11";
  };
}
```

### 3. Apply configuration

```bash
# Build and activate
home-manager switch --flake .#your-username
```

## Available Options

Each module supports:

| Module | Option | Description |
|--------|--------|-------------|
| alacritty | `dionysus.alacritty.enable` | Enable alacritty config |
| cava | `dionysus.cava.enable` | Enable cava audio visualizer |
| eww | `dionysus.eww.enable` | Enable eww widgets |
| hyprland | `dionysus.hyprland.enable` | Enable hyprland compositor |
| neofetch | `dionysus.neofetch.enable` | Enable neofetch config |
| rofi | `dionysus.rofi.enable` | Enable rofi launcher |
| waybar | `dionysus.waybar.enable` | Enable waybar status bar |
| zsh | `dionysus.zsh.enable` | Enable zsh shell config |

All modules also support a `package` option to override the default package.

## Updating Dotfiles

Simply edit files in the `dotfiles/` directory and rebuild:

```bash
home-manager switch --flake .#your-username
```

The configuration will symlink files from this flake to `~/.config/`.

## Pushing Updates

```bash
git add .
git commit -m "Describe your changes"
git push
```
