{ config, lib, pkgs, ... }:
with lib;
let
  cfg = config.zapret;
in
{
  options.zapret = {
    enable = mkEnableOption "Enable DPI (Deep packet inspection) bypass";
  };



  config = mkIf cfg.enable {
  services.zapret = {
   enable = true;
   params = 
  [
    "--dpi-desync=fake,disorder2"
    "--dpi-desync-ttl=1"
    "--dpi-desync-autottl=2"
  ];
  whitelist = 
  [
"1e100.net"
"ggpht.com"
"googleusercontent.com"
"googlevideo.com"
"gstatic.com"
"gvt1.com"
"l.google.com"
"m.youtube.com"
"nhacmp3youtube.com"
"play.google.com"
"wide-youtube.l.google.com"
"www.youtube.com"
"youtu.be"
"youtube-nocookie.com"
"youtube-studio.com"
"youtube-ui.l.google.com"
"youtube.be"
"youtube.ca"
"youtube.co"
"youtube.co.in"
"youtube.co.uk"
"youtube.com"
"youtube.com.au"
"youtube.com.br"
"youtube.com.mx"
"youtube.com.tr"
"youtube.com.ua"
"youtube.de"
"youtube.es"
"youtube.fr"
"youtube.googleapis.com"
"youtube.jp"
"youtube.nl"
"youtube.pl"
"youtube.pt"
"youtube.ru"
"youtubeapi.com"
"youtubechildren.com"
"youtubecommunity.com"
"youtubecreators.com"
"youtubeeducation.com"
"youtubeembeddedplayer.googleapis.com"
"youtubei.googleapis.com"
"youtubekids.com"
"yt-video-upload.l.google.com"
"yt.be"
"yt3.ggpht.com"
"ytimg.com"
"10tv.app"
"7tv.app"
"7tv.gg"
"7tv.io"
"api.7tv.app"
"cdn.7tv.app"
"cdn.7tv.gg"
"emotes.7tv.app"
"events.7tv.app"
"static.7tv.app"
"betterttv.net"
"frankerfacez.com"
"cdn.betterttv.net"
"cdn2.frankerfacez.com"
"cdn.frankerfacez.com"
"api.ffzap.com"
"api.frankerfacez.com""*.discord.app:*"
"*.discord.com"
"*.discord.com:*"
"*.discord.gg"
"*.discord.gg:*"
"*.discord.media"
"*.discordapp.com"
"*.discordapp.com:*"
"*.discordapp.net"
"*.discordapp.net:*"
"airhorn.solutions"
"airhornbot.com"
"bigbeans.solutions"
"cdn.discordapp.com"
"dis.gd"
"discord-activities.com"
"discord-attachments-uploads-prd.storage.googleapis.com"
"discord.app"
"discord.co"
"discord.com"
"discord.design"
"discord.dev"
"discord.gg"
"discord.gift"
"discord.gifts"
"discord.media"
"discord.new"
"discord.store"
"discord.tools"
"discordactivities.com"
"discordapp.com"
"discordapp.io"
"discordapp.net"
"discordcdn.com"
"discordmerch.com"
"discordpartygames.com"
"discordsays.com"
"discordsez.com"
"discordstatus.com"
"gateway.discord.gg"
"hammerandchisel.ssl.zendesk.com"
"images-ext-1.discordapp.net"
"media.discordapp.net"
"watchanimeattheoffice.com"
"www.discord.app"
"www.discord.com""rutracker.org"
"rutracker.net"
"rutracker.cr"
"rutracker.nl"
"rutracker.ru"
"rutracker.cc"
"rutracker.cloud"
"rutracker.in"
"rutracker.me"
"rutracker.is""soundcloud.com"
"m.soundcloud.com"
"api.soundcloud.com"
"developers.soundcloud.com"
"soundcloud.app"
"soundcloud.org"
"soundcloud.net"
"soundcloud.co"
"soundcloud.co.uk"
"soundcloud.fr"
"soundcloud.de"
"soundcloud.me"
"soundclouddesign.com"
"soundcloudpress.com"
"stream.soundcloud.com"
"soundcloudstatus.com"
"soundcloudforartists.com"
"w.soundcloud.com"
"sndcdn.com""cdn.akamai.steamstatic.com"
"cdn.cloudflare.steamstatic.com"
"cdn.edgecast.steamstatic.com"
"cdn.highwinds.steamstatic.com"
"cdn.steampipe.steamcontent.com"
"cdn.steampowered.com"
"cdn.steamstatic.com"
"csgo.wmsj.cn"
"dl.steam.clngaa.com"
"dl.steam.ksyna.com"
"dota2.wmsj.cn"
"edge.steam-dns.top.comcast.net"
"help.steampowered.com"
"media.steampowered.com"
"partner.steamgames.com"
"playartifact.com"
"s.team"
"st.dl.bscstorage.net"
"st.dl.eccdnx.com"
"st.dl.pinyuncloud.com"
"steam-api.com"
"steam-chat.com"
"steam.apac.qtlglb.com"
"steam.cdn.on.net"
"steam.cdn.orcon.net.nz"
"steam.cdn.slingshot.co.nz"
"steam.cdn.webra.ru"
"steam.eca.qtlglb.com"
"steam.naeu.qtlglb.com"
"steam.ru.qtlglb.com"
"steam.tv"
"steamapi.com"
"steambroadcast-l3-prod-prd.steamos.cloud"
"steambroadcast.akamaized.net"
"steambroadcast.steampowered.com"
"steambroadcastmedia-a.akamaihd.net"
"steamcdn-a.akamaihd.net"
"steamchina.com"
"steamcommunity-a.akamaihd.net"
"steamcommunity.com"
"steamcontent.com"
"steamdeck.com"
"steamgames.com"
"steamgift.com"
"steaminfra.com"
"steammobile.akamaized.net"
"steampipe-kr.akamaized.net"
"steampipe-partner.akamaized.net"
"steampipe.akamaized.net"
"steampipe.steamcontent.tnkjmec.com"
"steampowered.cn"
"steampowered.com"
"steampowered.com.8686c.com"
"steamserver.net"
"steamstatic.cn"
"steamstatic.com"
"steamstatic.com.8686c.com"
"steamstore-a.akamaihd.net"
"steamstore.com"
"steamtracker.com"
"steamusercontent-a.akamaihd.net"
"steamusercontent.com"
"steamuserimages-a.akamaihd.net"
"steamvideo-a.akamaihd.net"
"store.steampowered.com"
"underlords.com"
"valvesoftware.com"
"wmsjsteam.com"
"xz.pphimalayanrt.com""telegram.org"
"t.me"
"web.telegram.org"
"desktop.telegram.org"
"macos.telegram.org"
"telegram.me"
"telegram.dog"
"core.telegram.org"
"tdesktop.com"
"telegram.tips"
"telegramusercontent.com"
"webk.telegram.org"
"k.telegram.org"
"telesco.pe""app.twitch.tv"
"blog.twitch.tv"
"clips.twitch.tv"
"d1g1f25tn8m2e6.cloudfront.net"
"d1m7jfoe9zdc1j.cloudfront.net"
"d1mhjrowxxagfy.cloudfront.net"
"d1oca24q5dwo6d.cloudfront.net"
"d1w2poirtb3as9.cloudfront.net"
"d1xhnb4ptk05mw.cloudfront.net"
"d1ymi26ma8va5x.cloudfront.net"
"d2aba1wr3818hz.cloudfront.net"
"d2dylwb3shzel1.cloudfront.net"
"d2e2de1etea730.cloudfront.net"
"d2nvs31859zcd8.cloudfront.net"
"d2um2qdswy1tb0.cloudfront.net"
"d2vjef5jvl6bfs.cloudfront.net"
"d2xmjdvx03ij56.cloudfront.net"
"d36nr0u3xmc4mm.cloudfront.net"
"d3aqoihi2n8ty8.cloudfront.net"
"d3c27h4odz752x.cloudfront.net"
"d3vd9lfkzbru3h.cloudfront.net"
"d6d4ismr40iw.cloudfront.net"
"d6tizftlrpuof.cloudfront.net"
"dashboard.twitch.tv"
"ddacn6pr5v0tl.cloudfront.net"
"developer.twitch.tv"
"dgeft87wbj63p.cloudfront.net"
"dqrpb9wgowsf5.cloudfront.net"
"ds0h3roq6wcgc.cloudfront.net"
"dykkng5hnh52u.cloudfront.net"
"ext-twitch.tv"
"help.twitch.tv"
"jtvnw.net"
"live-video.net"
"m.twitch.tv"
"passport.twitch.tv"
"player.twitch.tv"
"status.twitch.tv"
"ttvnw.net"
"twitch.tv"
"twitchadvertising.tv"
"twitchcdn.net"
"twitchcon.com"
"twitchsvc.net"
"vod-secure.twitch.tv""ads-twitter.com"
"cms-twdigitalassets.com"
"periscope.tv"
"pscp.tv"
"t.co"
"tellapart.com"
"tweetdeck.com"
"twimg.com"
"twitpic.com"
"twitter.biz"
"twitter.com"
"twitter.jp"
"twittercommunity.com"
"twitterflightschool.com"
"twitterinc.com"
"twitteroauth.com"
"twitterstat.us"
"twtrdns.net"
"twttr.com"
"twttr.net"
"twvid.com"
"vine.co"
"x.com"
  ];

   };
  };
}
