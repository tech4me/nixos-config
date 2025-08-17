{ pkgs }:

with pkgs; [
  # General packages for development and system management
  bat
  coreutils
  difftastic
  eza
  fzf
  killall
  neofetch
  nodejs
  #pkg-config
  starship
  wezterm
  wget
  zip
  zoxide

  # LLVM packages
  #stdenv.cc.cc.lib
  #llvmPackages_latest.clang
  llvmPackages_latest.libclang.lib
  llvmPackages_latest.llvm
  llvmPackages_latest.llvm.dev
  llvmPackages_latest.mlir.dev

  # Media-related packages
  font-awesome

  # Text and terminal utilities
  htop
  ripgrep
  tmux
  unzip

  # Python packages
  python3
]
