# pinteresttgbot.nix
{ config, pkgs, inputs, ... }:
{
  systemd.services.media-downloader-bot = let
    pythonEnv = pkgs.python313.withPackages (ps: with ps; [
      aiogram
      aiohttp
    ]);
  in {
    description = "Telegram Media Downloader Bot";

    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];

    wantedBy = [ "multi-user.target" ];

    path = with pkgs; [
      yt-dlp
      ffmpeg
    ];

    serviceConfig = {
      Type = "simple";

      User = "misha";

      WorkingDirectory =
        "/home/misha/Documents/pinterest-bot";

      ExecStart =
        "${pythonEnv}/bin/python /home/misha/Documents/pinterest-bot/bot.py";

      Restart = "always";
      RestartSec = 5;
    };
  };
}
