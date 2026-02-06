{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dionysus.neofetch;
in
{
  options.dionysus.neofetch = {
    enable = mkEnableOption "Enable neofetch configuration";
    package = mkOption {
      type = types.package;
      default = pkgs.neofetch;
      description = "Neofetch package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      ".config/neofetch/config.conf" = {
        source = ../dotfiles/neofetch/config.conf;
        recursive = false;
      };
      ".config/neofetch/myascii.txt" = {
        source = ../dotfiles/neofetch/myascii.txt;
        recursive = false;
      };
      ".config/neofetch/animated-neofetch.sh" = {
        source = ../dotfiles/neofetch/animated-neofetch.sh;
        recursive = false;
        executable = true;
      };
      ".config/neofetch/frames_colour" = {
        source = ../dotfiles/neofetch/frames_colour;
        recursive = true;
      };
    };
  };
}
