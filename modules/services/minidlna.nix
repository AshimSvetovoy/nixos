{ config, pkgs, inputs, ... }:
{
services.minidlna = {
  enable = true;
  openFirewall = true; # Автоматически открывает порты 8200/TCP и 1900/UDP
  settings = {
    friendly_name = "Capybara";
    media_dir = [
      "V,/Disk/Смешарики/Смешарики 2D вселенная"
    ];
    inotify = "yes"; # Автоматическое обновление списка файлов
  };
};


}
