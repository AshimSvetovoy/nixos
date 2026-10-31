# packages.nix
{ config, pkgs, ... }:
let
  kate-with-konsole = pkgs.symlinkJoin {
    name = "kate-with-konsole";
    paths = [ pkgs.kdePackages.kate ];

    buildInputs = [ pkgs.makeWrapper ];

    postBuild = ''
      wrapProgram $out/bin/kate \
        --prefix PATH : ${pkgs.lib.makeBinPath [
          pkgs.kdePackages.konsole
        ]}
    '';
  };
in
{

  home.packages = with pkgs; [
    telegram-desktop
    vlc
    btop
    fastfetch
    xwayland-satellite
    qbittorrent
    steam-run
    appimage-run
    libreoffice-qt
    hunspell
    hunspellDicts.ru_RU
    hunspellDicts.en_US
    pulsemixer
    p7zip
    tmux
    qemu
    python3
    #luanti
    amneziawg-tools
    amneziawg-go
    mediawriter
    flameshot
    qalculate-gtk
    blender
    gimp
    remmina
    vscode
    ripgrep
    tree
    kdePackages.kdeconnect-kde
    kdePackages.filelight
    golly
    gcc
    zenity
    winetricks
    wineWow64Packages.stable
    freerdp
    bc
    dialog
    libnotify
    faugus-launcher
    prismlauncher
    ryubing
    ungoogled-chromium
    lutris-free
    tor-browser
    mousepad
    #emacs-gtk
    kate-with-konsole
  ];

}
