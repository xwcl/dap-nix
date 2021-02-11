{
  description = "ExAO DAP machine config";
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-20.09;
  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
        "dap" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [ ./hosts/dap.nix ];
      };
    };
  };
}
