{
  flake.nixosModules.nitter = {
    services.nitter = {
      enable = true;
      openFirewall = true;

      sessionsFile = "/var/lib/private/nitter/sessions.jsonl";

      server = {
        address = "0.0.0.0";
        port = 8000;
        hostname = "nitter.zkdl.online";
        title = "nitter";
        https = true;
        httpMaxConnections = 100;
      };

      cache = {
        listMinutes = 240;
        rssMinutes = 10;
      };

      config = {
        base64Media = false;
        enableDebug = false;
        enableRSS = true;
        tokenCount = 10;
        proxy = "";
        proxyAuth = "";
      };

      preferences = {
        theme = "Nitter";
        replaceTwitter = "nitter.zkdl.online";
        replaceYouTube = "";
        replaceReddit = "";
        hideBanner = false;
        hidePins = false;
        hideReplies = false;
        hideTweetStats = false;
        stickyProfile = true;
        bidiSupport = false;
        infiniteScroll = false;
        autoplayGifs = true;
        mp4Playback = true;
        hlsPlayback = false;
        muteVideos = false;
        proxyVideos = true;
        squareAvatars = false;
      };

      settings = { };

    };
  };
}
