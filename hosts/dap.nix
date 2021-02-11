{ config, pkgs, modulesPath, ... }:
let
  hostName = "dap";
  domain = "xwcl.science";
  webRoot = "/srv/www";
  maxHttpUploadMB = 200;
  pythonWithPip = pkgs.python3.withPackages(ps: with ps; [ pip setuptools ]);
  pythonAppEnv = (import ../python.nix) {};
in
{
  imports = [ "${modulesPath}/virtualisation/openstack-config.nix" ];

  # Production web server config
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    clientMaxBodySize = "${toString maxHttpUploadMB}M";
    logError = "stderr info";
    virtualHosts = {
      "${hostName}.${domain}" = {
          enableACME = true;
          forceSSL = true;
          root = webRoot;
          extraConfig = ''
            access_log syslog:server=unix:/dev/log;
          '';
          # locations = {
          #   "/".extraConfig = ''
          #     proxy_pass http://127.0.0.1:${toString vizzy.port};
          #   '';
          # };
      };
    };
  };

  systemd.services.webpermissions = {
    wantedBy = [ "multi-user.target" ];
    before = [ "nginx.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
    mkdir -p ${webRoot}
    chown -R ${config.services.nginx.user}:${config.services.nginx.group} ${webRoot}
    chmod -R u=rwX,g=rwX,o=rX ${webRoot}
    find ${webRoot} -type d -exec chmod g+s {} \;
    '';
  };

  networking.hostName = hostName;
  networking.domain = domain;
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  environment.systemPackages = with pkgs; [
    wget
    vim
    curl
    tmux
    git
    pythonWithPip
    gnumake
    unzip
  ];
  networking.firewall.allowedTCPPorts = [ 22 80 443 ];  # SSH, HTTP, HTTPS
  services.locate.enable = true;
  programs.bash.enableCompletion = true;
  security.sudo.wheelNeedsPassword = false;
  # ACME / LetsEncrypt config
  security.acme.acceptTerms = true;
  security.acme.email = "lynx@magao-x.org";

  # Enable automatic garbage collection
  nix.gc.automatic = true;
  nix.gc.dates = "03:15";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "20.09"; # Did you read the comment?
}
