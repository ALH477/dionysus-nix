{
  description = "Dionysus dotfiles flake - Nix modules for home-manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
    in
    {
      packages.${system} = {
        default = self.packages.${system}.dionysus-dotfiles;
        dionysus-dotfiles = pkgs.writeShellScriptBin "dionysus-dotfiles" ''
          echo "Dionysus dotfiles flake"
          echo "Available modules:"
          echo "  - alacritty"
          echo "  - cava"
          echo "  - eww"
          echo "  - hyprland"
          echo "  - neofetch"
          echo "  - rofi"
          echo "  - waybar"
          echo "  - zsh"
        '';
      };

      overlays.default = final: prev: {
        dionysus-dotfiles = self.packages.${system}.dionysus-dotfiles;
      };

      nixosModules = {
        dionysus = {
          imports = [ ./modules ];
        };
      };

      homeManagerModules = {
        dionysus = {
          imports = [ ./modules ];
        };
      };

      formatter.${system} = pkgs.nixfmt;
    };
}
