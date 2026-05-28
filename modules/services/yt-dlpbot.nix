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

  ytBotWrapper = pkgs.writeShellScript "yt-bot" ''
    exec ${ytDlpTelegramBot}/bin/yt-dlp-telegram-bot \
      -bot-token "$BOT_TOKEN" \
      -api-id "$API_ID" \
      -api-hash "$API_HASH" \
      -admin-user-ids "$ADMIN_USER_IDS"
  '';

in
{
  # зависимости
  environment.systemPackages = with pkgs; [
    yt-dlp
    ffmpeg
  ];

  # пользователь
  users.groups.ytdlpbot = {};

  users.users.ytdlpbot = {
    isSystemUser = true;
    group = "ytdlpbot";
    home = "/var/lib/yt-dlp-telegram-bot";
    createHome = false;   # ❗ systemd создаст сам
  };

  # сервис
  systemd.services.yt-dlp-telegram-bot = {
    description = "Telegram yt-dlp bot";

    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];

    serviceConfig = {
      Type = "simple";

      User = "ytdlpbot";

      # ❗ systemd сам создаёт /var/lib/yt-dlp-telegram-bot
      StateDirectory = "yt-dlp-telegram-bot";
      StateDirectoryMode = "0750";

      WorkingDirectory = "/var/lib/yt-dlp-telegram-bot";

      EnvironmentFile = "/var/lib/yt-dlp-telegram-bot/secrets.env";

      ExecStart = "${ytBotWrapper}";

      Restart = "always";
      RestartSec = 5;

      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}