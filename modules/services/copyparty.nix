# copyparty.nix
{ config, pkgs, inputs, ... }:

{
services.copyparty = {
  enable = true;
  user = "misha";
  group = "users";

  settings = {
    i = "0.0.0.0";
    p = 3939;
    no-reload = true;
  };

  volumes = {
    "/" = {
      path = "/home/misha";
      access.r = "*";
    };
  };
  openFilesLimit = 8192;
};
}
