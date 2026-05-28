{ config, pkgs, inputs, ... }:

{
  services.code-server = {
    enable = true;
     port = 9393;
     host = "0.0.0.0";
     user = "misha";
     auth = "none";
  };  
 
}
