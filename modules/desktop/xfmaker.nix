# xfmaker.nix
{ config, pkgs, inputs, ... }:
{
  xdg.portal = {
    enable = true;
    # Добавляем портал для Xfce (ваш desktop environment)
    xdgOpenUsePortal = true;
    # Настраиваем порталы (порядок важен)
    config.common.default = [ "gtk" "xfce" ];  # Для Xfce
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk  # Для GTK-приложений
      # xdg-desktop-portal-xfce может быть не в nixpkgs, используем gtk
    ];
  };

  services.xserver = {
    enable = true;
    
    # Включаем Xfce как desktop-менеджер
    desktopManager = {
      xterm.enable = false;
      xfce = {
        enable = true;
        # Отключаем xfwm4 (штатный оконный менеджер Xfce)
        enableXfwm = false;
        # Отключаем xfdesktop (управление иконками на рабочем столе)
        # Опционально: если хотите использовать desktop из Window Maker
        #noDesktop = true;
      };
    };
    
    # Включаем Window Maker как оконный менеджер
    windowManager.windowmaker.enable = true;
    
    # Настраиваем дисплейный менеджер
    displayManager = {
      lightdm.enable = true;
      # Указываем сессию "xfce+windowmaker"
      defaultSession = "xfce+windowmaker";
    };
  };
  
  # Дополнительные пакеты (теперь плагины будут работать без оберток!)
  environment.systemPackages = with pkgs; [ 
    xfce.xfce4-terminal 
    mate.engrampa
    xfce.xfce4-xkb-plugin
    xfce.xfce4-systemload-plugin
    xfce.xfce4-pulseaudio-plugin
  ];
}
