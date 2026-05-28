{ config, pkgs, ... }:

let
  ytDlpTelegramBot = pkgs.buildGoModule {
    pname = "yt-dlp-telegram-bot";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "nonoo";
      repo = "yt-dlp-telegram-bot";
      rev = "master";
      sha256 = "sha256-rxGyrjmRMUALTklHTiHw1JBBreTiZH4tfOOZDY+Le5U=";
    };

    vendorHash = "sha256-scw2jWx636YPzJQxjHdFsrAwq2TD9cIyMftY2kS1aXQ=";
  };
in
{
  # зависимости системы
  environment.systemPackages = with pkgs; [
    yt-dlp
    ffmpeg
  ];

  # пользователь сервиса
  users.users.ytdlpbot = {
    isSystemUser = true;
    home = "/var/lib/yt-dlp-telegram-bot";
    createHome = true;
  };

  # systemd сервис
  systemd.services.yt-dlp-telegram-bot = {
    description = "Telegram yt-dlp bot";

    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";

      User = "ytdlpbot";
      WorkingDirectory = "/var/lib/yt-dlp-telegram-bot";

      # секреты берутся из файла
      EnvironmentFile = "/var/lib/yt-dlp-telegram-bot/secrets.env";

      ExecStart = ''
        ${pkgs.bash}/bin/bash -c '
          exec ${ytDlpTelegramBot}/bin/yt-dlp-telegram-bot \
            -bot-token "$BOT_TOKEN" \
            -api-id "$API_ID" \
            -api-hash "$API_HASH" \
            -admin-user-ids "$ADMIN_USER_IDS"
        '
      '';

      Restart = "always";
      RestartSec = 5;

      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };

  users.groups.ytdlpbot = {};

users.users.ytdlpbot = {
  isSystemUser = true;
  home = "/var/lib/yt-dlp-telegram-bot";
  createHome = true;
  group = "ytdlpbot";
};
}