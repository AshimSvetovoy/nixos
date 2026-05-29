# 3proxy.nix
{ config, pkgs, inputs, ... }:

{
    services._3proxy = {
    enable = true;
    services = [
      {
        type = "proxy";
        auth = [ "none" ];
        bindPort = 3128;
        bindAddress = "0.0.0.0";
        acl = [{
          rule = "allow";
          users = [];
        }];
      }
    ];
  };
}
