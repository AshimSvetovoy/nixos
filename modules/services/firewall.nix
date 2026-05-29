# firewall.nix
{ config, pkgs, inputs, ... }:
{
networking.firewall.enable = false;
#                             ^
#                             |
# когда-нибудь исправлю это недоразумение 
}
