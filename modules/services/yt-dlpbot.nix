{ config, pkgs, ... }:

let
  ytDlpTelegramBot = pkgs.buildGoModule {
    pname = "yt-dlp-telegram-bot";
    version = "latest";

    src = pkgs.fetchFromGitHub {
      owner = "nonoo";
      repo = "yt-dlp-telegram-bot";
      rev = "master";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    };

    vendorHash = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB=";
  };
in
{
  environment.systemPackages = with pkgs; [
    yt-dlp
    ffmpeg
  ];

  systemd.services.yt-dlp-telegram-bot = {
    description = "Telegram yt-dlp bot";
    after = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "simple";

      ExecStart = ''
        ${ytDlpTelegramBot}/bin/yt-dlp-telegram-bot \
          -bot-token "$BOT_TOKEN" \
          -api-id "$API_ID" \
          -api-hash "$API_HASH" \
          -admin-user-ids "$ADMIN_USER_IDS"
      '';

      Restart = "always";
      RestartSec = 5;

      DynamicUser = true;

      StateDirectory = "yt-dlp-telegram-bot";
      WorkingDirectory = "/var/lib/yt-dlp-telegram-bot";

      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}