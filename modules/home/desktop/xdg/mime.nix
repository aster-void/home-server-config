{
  xdg.mime.enable = true;
  xdg.mimeApps = let
    browser = "zen-beta.desktop";
    mailing = "userapp-Thunderbird-7X5TC3.desktop";
    calendar = "userapp-Thunderbird-7X5TC3.desktop";
  in {
    enable = true;
    defaultApplications = {
      "text/html" = browser;
      "text/xml" = browser;
      "image/png" = browser;
      "image/jpeg" = browser;
      "image/jpg" = browser;
      "application/x-extension-html" = browser;
      "application/x-extension-htm" = browser;
      "application/x-extension-shtml" = browser;
      "application/x-extension-xhtml" = browser;
      "application/x-extension-xht" = browser;
      "application/xhtml+xml" = browser;
      "application/pdf" = browser;
      "x-scheme-handler/ftp" = browser;
      "x-scheme-handler/http" = browser;
      "x-scheme-handler/https" = browser;
      "x-scheme-handler/chrome" = browser;
      "x-scheme-handler/discord" = "discord.desktop";
      "x-scheme-handler/slack" = "slack.desktop";
      "x-scheme-handler/notion" = "notion-app-enhanced.desktop";
      "application/x-zoom" = "us.zoom.Zoom.desktop";
      "x-scheme-handler/zoommtg" = "us.zoom.Zoom.desktop";
      "x-scheme-handler/mailto" = mailing;
      "message/rfc822" = mailing;
      "x-scheme-handler/mid" = mailing;
      "x-scheme-handler/webcal" = calendar;
      "text/calendar" = calendar;
      "application/x-extension-ics" = calendar;
      "x-scheme-handler/webcals" = calendar;
    };
  };
}
