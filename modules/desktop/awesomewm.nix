# i3wm.nix
{ config, pkgs, inputs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.awesome = {
      enable = true;
    };
  };

  services.displayManager.ly.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.excludePackages = [ pkgs.xterm ];
  services.tumbler.enable = true;
  services.gvfs.enable = true;
  environment.systemPackages = with pkgs; [
    nemo
    engrampa
    alacritty
    #picom
    papirus-icon-theme
    nwg-look
    xdg-utils
    xdg-desktop-portal 
    xdg-desktop-portal-gtk
    feh
    gxkb
    xclip
    ristretto
	dracula-theme
  ];
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };
}
