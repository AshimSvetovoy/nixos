# system.nix
{ config, pkgs, inputs, ... }:

{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "capybara"; # Define your hostname.
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };
  # OpenGL
  hardware.graphics.enable = true;

  # Configure keymap in X11
    services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

    users.users.misha = {
    isNormalUser = true;
    description = "misha";
    extraGroups = [ "networkmanager" "wheel" "libvirtd"];
    packages = with pkgs; [
    #  thunderbird
    ];
  };
  fonts.fontconfig.enable = true;
  
  console = {
    enable = true;
    # 16 ANSI-цветов в формате hex (без знака '#') на основе палитры Dracula
    colors = [
      "282a36" "ff5555" "50fa7b" "f1fa8c" # 0-3:   Black, Red, Green, Yellow
      "bd93f9" "ff79c6" "8be9fd" "f8f8f2" # 4-7:   Blue, Magenta, Cyan, White
      "6272a4" "ff5555" "50fa7b" "f1fa8c" # 8-11:  Bright Black, Bright Red, Bright Green, Bright Yellow
      "bd93f9" "ff79c6" "8be9fd" "ffffff" # 12-15: Bright Blue, Bright Magenta, Bright Cyan, Bright White
    ];
  };

  system.stateVersion = "26.05";
}
