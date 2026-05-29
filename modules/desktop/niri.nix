# niri.nix
  { config, pkgs, inputs, ... }:
{
services.displayManager.ly.enable = true;

  programs.niri.enable = true;
  environment.systemPackages = with pkgs; [
    wl-clipboard
    wayland-utils
    alacritty
    nwg-look
    nautilus
    noctalia-shell
    catppuccin-gtk
    papirus-icon-theme
    bibata-cursors
    kdePackages.kate
    file-roller
    loupe
  ];

  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gnome 
      pkgs.xdg-desktop-portal-gtk 
    ];
    config = {
      # Настройка приоритетов для niri
      niri = {
        default = [ "gnome" "gtk" ];
        # Можно явно указать использование gnome для скриншотов/шаринга
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
      };
    };
  };

  # Also enable GVfs (required for Nautilus)
  services.gvfs.enable = true;

}

