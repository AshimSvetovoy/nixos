  { config, pkgs, inputs, ... }:
{
  #boot.plymouth.enable = true;
  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    #displayManager.sddm.wayland.enable = true;
    xserver.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    kdePackages.kmines
  ];
  programs.aeroshell = {
  enable = true;
  #fonts.segoe.enable = true;
  polkit.enable = true;
  aerothemeplasma = {
    enable = true;
    sddm.enable = true;
    #plymouth.enable = true;
  };
};

}
