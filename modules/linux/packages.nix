{ pkgs }:

let
  shared = import ../shared/packages.nix { inherit pkgs; };
in
shared ++ (with pkgs; [
  # Linux toolchain for building outside derivations
  gcc
  binutils
  glibc.dev
  stdenv.cc.cc.lib
])


