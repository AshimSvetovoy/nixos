# i3wm.nix
 { config, pkgs, inputs, ... }:
{
  services.xserver = {
    enable = true;
    windowManager.i3 = {
    enable = true
    i3status
    rofi
    i3lock
    }
  }
  services.displayManager.ly.enable = true;
  
  environment.systemPackages = with pkgs; [
    thunar
    engrampa
    alacritty
    picom
    papirus-icon-theme
    nwg-look
  ];
}
