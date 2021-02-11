{ config, ... }:
{
  users.extraUsers.josephlong = {
    isNormalUser = true;
    initialPassword = "nixpassword1";
    description = "Joseph Long";
    extraGroups = ["wheel" config.services.nginx.group ];
    uid = 1000;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBYueVkn8YLWuEH9BMll4JoV6/0t1Is1idD1cuvy4OUA"
    ];
  };
  users.extraUsers.jaredmales = {
    isNormalUser = true;
    initialPassword = "nixpassword1";
    description = "Jared Males";
    extraGroups = ["wheel" config.services.nginx.group ];
    uid = 1001;
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgljnOjt+LzIVwgOzlfN76785mD7pq3sb/A8Xp7/3cN jrmales@mx9"
    ];
  };
}
