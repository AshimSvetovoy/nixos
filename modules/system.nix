# system.nix
{ config, pkgs, inputs, ... }:

{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages;
  boot.extraModulePackages = with config.boot.kernelPackages ; [ amneziawg ] ; 
  boot.blacklistedKernelModules = [ "af_alg" "algif_hash" "algif_skcipher" "algif_rng" "algif_aead" ];

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

 nixpkgs.overlays = [
  (final: prev: {
    openldap = prev.openldap.overrideAttrs (oldAttrs: {
      doCheck = false;
    });
  })
];

  system.stateVersion = "26.05";
}
