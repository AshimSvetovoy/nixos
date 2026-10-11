# packages.nix
{ config, pkgs, ... }: 
{
    environment.systemPackages = with pkgs; [
    vim
    wget
    mc
    gparted
    git
    home-manager
 ];
 
  programs.firefox.enable = true;
  
  nixpkgs.config.allowUnfree = true;

  fonts.fontDir.enable = true;



fonts.packages = with pkgs; [
  nerd-fonts.fira-code
  nerd-fonts.jetbrains-mono
  nerd-fonts.hack
  noto-fonts
  dejavu_fonts
  liberation_ttf
  freefont_ttf
  xorg.fontmiscmisc
  xorg.fontcursormisc

];
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};

}
