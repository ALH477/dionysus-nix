{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dionysus.eww;
in
{
  options.dionysus.eww = {
    enable = mkEnableOption "Enable eww configuration";
    package = mkOption {
      type = types.package;
      default = pkgs.eww;
      description = "Eww package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      ".config/eww/eww.yuck" = {
        source = ../dotfiles/eww/eww.yuck;
        recursive = false;
      };
      ".config/eww/eww.scss" = {
        source = ../dotfiles/eww/eww.scss;
        recursive = false;
      };
      ".config/eww/eww-state.yml" = {
        source = ../dotfiles/eww/eww-state.yml;
        recursive = false;
      };
      ".config/eww/scripts" = {
        source = ../dotfiles/eww/scripts;
        recursive = true;
      };
      ".config/eww/windows" = {
        source = ../dotfiles/eww/windows;
        recursive = true;
      };
    };
  };
}
