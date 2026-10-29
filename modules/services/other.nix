# other.nix
{ config, pkgs, inputs, ... }:

{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
  libXtst
  # You may also want to add other common X11 libraries
  # that Minecraft often needs:
  libX11
  libXext
  libXrandr
  libXcursor
  libXi
  ];
  
services.openssh.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.flatpak.enable = true;

  services.resolved.enable = true;
    programs.throne = {
    enable = true;
    tunMode.enable = true;
  };


}
