{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.dionysus.zsh;
in
{
  options.dionysus.zsh = {
    enable = mkEnableOption "Enable zsh configuration";
    package = mkOption {
      type = types.package;
      default = pkgs.zsh;
      description = "Zsh package to use";
    };
  };

  config = mkIf cfg.enable {
    programs.zsh = {
      enable = true;
      dotfile = ../dotfiles/zsh/.zshrc;
    };

    home.file = {
      ".zshrc" = {
        source = ../dotfiles/zsh/.zshrc;
        recursive = false;
      };
    };
  };
}
