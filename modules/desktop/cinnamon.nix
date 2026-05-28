  { config, pkgs, inputs, ... }:

{
  programs.dconf.enable = true;
  services.xserver = { 
    displayManager.lightdm.enable = true;
    enable = true;
    desktopManager = {
    xterm.enable = false;
    cinnamon.enable = true;
  };
};

}
