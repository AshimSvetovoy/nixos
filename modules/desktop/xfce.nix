# xfce.nix
  { config, pkgs, inputs, ... }:

{
  services.xserver = {
  enable = true;
  displayManager.lightdm.enable = true;
  desktopManager = {
    xterm.enable = false;
    xfce.enable = true;
  }; };
environment.systemPackages = with pkgs; [
    xfce.xfce4-xkb-plugin
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-systemload-plugin
];

}
