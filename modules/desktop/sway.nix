#sway.nix

{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard # Copy/Paste functionality.
    mako # Notification utility.
    #waybar
    nwg-look
    thunar
    loupe
    thunar
    papirus-icon-theme
    bibata-cursors
  ];

  # Enables Gnome Keyring to store secrets for applications. 
  services.gnome.gnome-keyring.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gnome 
      pkgs.xdg-desktop-portal-gtk 
    ];
 };

  # Enable Sway.
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  console = {
    enable = true;
    colors = [
      "282828" # 0: Black (bg0)
      "cc241d" # 1: Red
      "98971a" # 2: Green
      "d79921" # 3: Yellow
      "458588" # 4: Blue
      "b16286" # 5: Magenta
      "689d6a" # 6: Cyan
      "a89984" # 7: White (fg4)
      "928374" # 8: Bright Black (Gray)
      "fb4934" # 9: Bright Red
      "b8bb26" # 10: Bright Green
      "fabd2f" # 11: Bright Yellow
      "83a598" # 12: Bright Blue
      "d3869b" # 13: Bright Magenta
      "8ec07c" # 14: Bright Cyan
      "ebdbb2" # 15: Bright White (fg1)
    ];
  };
  
  services.displayManager.ly.enable = true;
}
