# virtualstuff.nix
{ config, pkgs, inputs, ... }:
{
  virtualisation.libvirtd.enable = true;
    # vmware
  virtualisation.vmware.host.enable = true;
  boot.kernelParams = [ "transparent_hugepage=never" ];
  
    #virtualbox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "misha" ];
}
