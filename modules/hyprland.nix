{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dionysus.hyprland;
in
{
  options.dionysus.hyprland = {
    enable = mkEnableOption "Enable hyprland configuration";
    package = mkOption {
      type = types.package;
      default = pkgs.hyprland;
      description = "Hyprland package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      ".config/hypr/hyprland.conf" = {
        source = ../dotfiles/hypr/hyprland.conf;
        recursive = false;
      };
      ".config/hypr/hyprpaper.conf" = {
        source = ../dotfiles/hypr/hyprpaper.conf;
        recursive = false;
      };
      ".config/hypr/scripts" = {
        source = ../dotfiles/hypr/scripts;
        recursive = true;
      };
      ".config/hypr/shaders" = {
        source = ../dotfiles/hypr/shaders;
        recursive = true;
      };
      ".config/hypr/wallpapers" = {
        source = ../dotfiles/hypr/wallpapers;
        recursive = true;
      };
      ".config/hypr/extras" = {
        source = ../dotfiles/hypr/extras;
        recursive = true;
      };
    };
  };
}
