# wmaker.nix
{ config, pkgs, inputs, ... }:
let
  # Создаем обертку, которая объединяет панель и плагины в одно окружение
  xfce4-panel-wrapped = pkgs.symlinkJoin {
    name = "xfce4-panel-with-plugins";
    paths = [
      pkgs.xfce.xfce4-panel
      pkgs.xfce.xfce4-xkb-plugin
      pkgs.xfce.xfce4-systemload-plugin
      pkgs.xfce.xfce4-pulseaudio-plugin
    ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      # Находим все директории, где лежат плагины
      PLUGIN_DIRS=""
      for plugin in ${pkgs.xfce.xfce4-xkb-plugin} ${pkgs.xfce.xfce4-systemload-plugin} ${pkgs.xfce.xfce4-pulseaudio-plugin} ${pkgs.xfce.xfce4-panel}; do
        if [ -d "$plugin/lib/xfce4/panel/plugins" ]; then
          PLUGIN_DIRS="$PLUGIN_DIRS:$plugin/lib/xfce4/panel/plugins"
        fi
      done
      # Убираем двоеточие в начале
      PLUGIN_DIRS="''${PLUGIN_DIRS#:}"
      
      wrapProgram $out/bin/xfce4-panel \
        --set X_XFCE4_LIB_DIRS "$PLUGIN_DIRS"
    '';
  };
in
{
  services.xserver.enable = true;
  services.xserver.windowManager.windowmaker.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  programs.thunar.enable = true;

  environment.systemPackages = with pkgs; [ 
    nwg-look
    rofi
    xfce.xfce4-terminal 
    dockapps.wmCalClock
    dockapps.wmcube
    dockapps.wmsystemtray
    pulsemixer
    mate.engrampa
    xfce4-panel-wrapped  # <-- используем обертку вместо оригинальной панели
  ];
}
