{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dionysus.cava;
in
{
  options.dionysus.cava = {
    enable = mkEnableOption "Enable cava configuration";
    package = mkOption {
      type = types.package;
      default = pkgs.cava;
      description = "Cava package to use";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];

    home.file = {
      ".config/cava/config" = {
        source = ../dotfiles/cava/config;
        recursive = false;
      };
      ".config/cava/shaders" = {
        source = ../dotfiles/cava/shaders;
        recursive = true;
      };
    };
  };
}
