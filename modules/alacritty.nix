{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dionysus.alacritty;
in
{
  options.dionysus.alacritty = {
    enable = mkEnableOption "Enable alacritty configuration";
    package = mkOption {
      type = types.package;
      default = pkgs.alacritty;
      description = "Alacritty package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      ".config/alacritty/alacritty.toml" = {
        source = ../dotfiles/alacritty/alacritty.toml;
        recursive = false;
      };
    };
  };
}
