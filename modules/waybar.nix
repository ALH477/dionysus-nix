{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dionysus.waybar;
in
{
  options.dionysus.waybar = {
    enable = mkEnableOption "Enable waybar configuration";
    package = mkOption {
      type = types.package;
      default = pkgs.waybar;
      description = "Waybar package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      ".config/waybar/config" = {
        source = ../dotfiles/waybar/config;
        recursive = false;
      };
      ".config/waybar/style.css" = {
        source = ../dotfiles/waybar/style.css;
        recursive = false;
      };
      ".config/waybar/scripts" = {
        source = ../dotfiles/waybar/scripts;
        recursive = true;
      };
    };
  };
}
