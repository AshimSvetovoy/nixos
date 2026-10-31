# home.nix
{ config, pkgs, ... }:

{
    imports = [
    ./packages.nix
  ];
  home.username = "misha";
  home.homeDirectory = "/home/misha";
  home.stateVersion = "26.05";

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture
      obs-vaapi #optional AMD hardware acceleration
      obs-gstreamer
      obs-vkcapture
    ];
  };
  
  programs.yazi.enable = true;
  
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      alias q='exit'
      alias rebuild='sudo nixos-rebuild switch --flake /home/misha/nixos#nixos'
      alias rebuild-boot='sudo nixos-rebuild boot --flake /home/misha/nixos#nixos'
      alias n='nvim'
      alias warpup='sudo awg-quick up warp'
      alias warpdown='sudo awg-quick down warp'
      alias pg='ping google.com'

      nr() {
        nix run "nixpkgs#$1" -- "''${@:2}"
      }
    '';
  };

   home.pointerCursor = {
    x11.enable = true;
    name = "Bibata-Modern-Ice";       # Replace with your desired cursor theme name
    package = pkgs.bibata-cursors; # Replace with the package providing the theme
    size = 24;                # Adjust cursor size as needed
    gtk.enable = true;
  };
 

}
