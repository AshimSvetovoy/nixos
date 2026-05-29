# bootloader.nix
{ config, pkgs, inputs, ... }:

{
    # UEFI Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
