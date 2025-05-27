{ config, pkgs, lib, ... }:

let
  user = "syin";
in
{
  imports = [
    ../../modules/shared/home-manager.nix
  ];

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    stateVersion = "24.05"; # Please check the Home Manager release notes before changing.
    
    # Install packages
    packages = import ../../modules/shared/packages.nix { inherit pkgs; };
  };

  # Enable home-manager
  programs.home-manager.enable = true;
} 