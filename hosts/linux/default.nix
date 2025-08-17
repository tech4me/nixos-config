{ config, pkgs, lib, ... }:

let
  user = "syin";
  shared-programs = import ../../modules/shared/home-manager.nix { inherit config pkgs lib; };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = "24.05"; # Please check the Home Manager release notes before changing.
    sessionVariables = {
      CPATH = "$HOME/.nix-profile/include";
      LIBRARY_PATH = "$HOME/.nix-profile/lib";
    };
    
    # Install packages (Linux-specific bundle)
    packages = import ../../modules/linux/packages.nix { inherit pkgs; };
  };

  # Import shared programs
  programs = shared-programs // {
    # Enable home-manager
    home-manager.enable = true;
  };
} 