{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dionysus.rofi;
in
{
  options.dionysus.rofi = {
    enable = mkEnableOption "Enable rofi configuration";
    package = mkOption {
      type = types.package;
      default = pkgs.rofi;
      description = "Rofi package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      ".config/rofi/config.rasi" = {
        source = ../dotfiles/rofi/config.rasi;
        recursive = false;
      };
      ".config/rofi/theme.rasi" = {
        source = ../dotfiles/rofi/theme.rasi;
        recursive = false;
      };
    };
  };
}
