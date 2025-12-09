{config, ...}: let
  primaryFont = "Speculum";
  smallFont = "Tinos Nerd Font";
  smallFontSize = 14;
  fontColor = "rgba(235, 215, 225, 1.0)";
  shadowColor = "rgb(160, 160, 160)";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        ignore_empty_input = true;
        no_fade_in = true;
        no_fade_out = true;
        hide_cursor = true;
        grace = 0;
        disable_loading_bar = true;
      };

      background = [
        {
          monitor = "";
          path = "${config.xdg.configHome}/lock";
          blur_passes = 3;
          blur_size = 3;
          noise = 0.05;
          contrast = 1;
          brightness = 0.8;
          vibrancy = 0.2;
          vibrancy_darkness = 0.2;
        }
      ];

      input-field = [
        {
          outline_thickness = 2;
          dots_size = 0.2;
          dots_spacing = 0.5;
          dots_center = true;
          dots_text_format = "<b>*</b>";
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(225, 215, 244, 0.2)";
          font_color = "rgba(205, 214, 244, 1)";
          font_family = "JetBrainsMono Nerd Font Mono";
          font_size = 30;
          fade_on_empty = false;
          rounding = 0;
          check_color = "rgba(204, 136, 34, 1)";
          placeholder_text = ''<b><span foreground="##cdd6f4">...</span></b>'';
          fail_text = "<b><span>x</span></b>";
          hide_input = true;
          position = "0, -120";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        # Date
        {
          monitor = "0";
          text = ''cmd[update:1000] echo "<span fgalpha='75%'>$(date +"%D")</span>"'';
          color = fontColor;
          font_size = 60;
          font_family = primaryFont;
          shadow_passes = 2;
          shadow_size = 2;
          shadow_color = shadowColor;
          position = "355, -35";
          text_align = "right";
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "0";
          text = "$TIME12";
          color = fontColor;
          font_size = 110;
          font_family = primaryFont;
          shadow_passes = 2;
          shadow_size = 2;
          shadow_color = shadowColor;
          position = "0, 70";
          text_align = "center";
          halign = "center";
          valign = "center";
        }
        # CPU info
        {
          monitor = "0";
          text = ''cmd[update:5000] echo "$(echo "$(cat /sys/class/thermal/thermal_zone2/temp)/1000" | bc)°C :CPU Temp<br/>$(top -bn1 | grep "Cpu(s)" | \sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | \awk '{print 100 - $1"%"}') :CPU Load"'';
          color = fontColor;
          font_size = smallFontSize;
          font_family = smallFont;
          shadow_passes = 2;
          shadow_size = 2;
          shadow_color = shadowColor;
          position = "-1120, -120";
          text_align = "right";
          halign = "right";
          valign = "center";
        }
      ];
    };
  };
}
