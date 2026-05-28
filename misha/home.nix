{ config, pkgs, ... }:

{
    imports = [
    ./packages.nix
  ];
  home.username = "misha";
  home.homeDirectory = "/home/misha";
  home.stateVersion = "26.05";


  programs.yazi.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;  # Это установит $EDITOR=nvim
    viAlias = true;        # Создаст алиас vi -> nvim
    vimAlias = true;       # Создаст алиас vim -> nvim
  };

  
  programs.bash = {
    enable = true;
    bashrcExtra = "
      alias q='exit'
      alias rebuild='sudo nixos-rebuild switch --flake /home/misha/nixos#nixos'
      alias rebuild-boot='sudo nixos-rebuild boot --flake /home/misha/nixos#nixos'
      alias n='nvim'
      alias warpup='sudo awg-quick up WARP'
      alias warpdown='sudo awg-quick down WARP'
      alias pg='ping google.com'
      fastfetch";
  };

  

}
