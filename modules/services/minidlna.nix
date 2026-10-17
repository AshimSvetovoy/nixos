# minidlna.nix
{ config, pkgs, inputs, ... }:
{
services.minidlna = {
  enable = true;
  openFirewall = true; # Автоматически открывает порты 8200/TCP и 1900/UDP
  settings = {
    friendly_name = "Capybara";
    media_dir = [
      "V,/home/misha/Videos"
    ];
    inotify = "yes"; # Автоматическое обновление списка файлов
  };
};


}
