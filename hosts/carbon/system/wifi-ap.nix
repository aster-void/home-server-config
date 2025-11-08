{config, ...}: let
  wifiSecret = config.age.secrets."carbon-wifi-pass";
in {
  age.secrets."carbon-wifi-pass" = {
    file = ../../../secrets/wifi/carbon-wifi.age;
    owner = "root";
    group = "root";
    mode = "0400";
  };

  networking.networkmanager.unmanaged = ["wlp2s0"];

  networking.interfaces.wlp2s0 = {
    useDHCP = false;
    ipv4.addresses = [
      {
        address = "10.88.0.1";
        prefixLength = 24;
      }
    ];
  };

  services.hostapd = {
    enable = true;
    radios.wlp2s0 = {
      band = "5g";
      channel = 36;
      countryCode = "JP";
      networks.wlp2s0 = {
        ssid = "carbon-wifi";
        authentication = {
          mode = "wpa3-sae";
          saePasswordsFile = wifiSecret.path;
        };
      };
    };
  };

  services.dnsmasq = {
    enable = true;
    settings = {
      interface = "wlp2s0";
      "bind-interfaces" = true;
      "domain-needed" = true;
      "bogus-priv" = true;
      "dhcp-range" = "10.88.0.10,10.88.0.100,12h";
      "dhcp-option" = [
        "3,10.88.0.1"
        "6,1.1.1.1"
      ];
      server = ["1.1.1.1"];
    };
  };

  networking.firewall.allowedTCPPorts = [53];
  networking.firewall.allowedUDPPorts = [
    53
    67
    68
  ];

  networking.nat = {
    enable = true;
    externalInterface = "enp3s0f4u2";
    internalInterfaces = ["wlp2s0"];
  };
}
