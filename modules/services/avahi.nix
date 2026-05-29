# avahi.nix
{ config, pkgs, inputs, ... }:

{
  services.avahi = {
    enable = true;
    nssmdns4 = true;       # Включает поддержку .local в системном резолвере
    publish = {
      enable = true;
      addresses = true;   # Публикует IP-адреса компьютера
      workstation = true; # (Опционально) Публикует тип "рабочая станция"
    };
  };
}
