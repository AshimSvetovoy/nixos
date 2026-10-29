# home.nix
{ config, pkgs, ... }:

{
    imports = [
    ./packages.nix
  ];
  home.username = "misha";
  home.homeDirectory = "/home/misha";
  home.stateVersion = "26.05";

  programs.neovim = {
    enable = true;
    defaultEditor = true;  # Это установит $EDITOR=nvim
    viAlias = true;        # Создаст алиас vi -> nvim
    vimAlias = true;       # Создаст алиас vim -> nvim
  };  

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
    bashrcExtra = "
      alias q='exit'
      alias rebuild='sudo nixos-rebuild switch --flake /home/misha/nixos#nixos'
      alias rebuild-boot='sudo nixos-rebuild boot --flake /home/misha/nixos#nixos'
      alias n='nvim'
      alias warpup='sudo awg-quick up warp'
      alias warpdown='sudo awg-quick down warp'
      alias pg='ping google.com'
      ";
  };

  

}
