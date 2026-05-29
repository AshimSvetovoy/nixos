# clash-verge.nix
{ config, pkgs, ... }:

{
  # Enable the clash-verge service and GUI
  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    
    # Enable Setcap for TUN Mode (expects boolean)
    tunMode = true;
    
    # Enable Service Mode (expects boolean)
    serviceMode = true; 
  };
}

