{
  description = "misha nixos";

  inputs = {
    # Use the unstable branch or a specific stable release
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    copyparty.url = "github:9001/copyparty";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    aerothemeplasma-nix = {
      url = "github:nyakase/aerothemeplasma-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, copyparty, home-manager, aerothemeplasma-nix, ... }@inputs: {
    nixosConfigurations = {
      
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };  # Add this line to pass inputs
        modules = [
          #system
          ./hardware-configuration.nix
          ./modules/packages.nix
          ./modules/system.nix
          ./modules/virtualstuff.nix
          ./modules/bootloader.nix
          # services
          ./modules/services/other.nix
          ./modules/services/minidlna.nix
          ./modules/services/3proxy.nix
          ./modules/services/copyparty.nix
          ./modules/services/firewall.nix
          ./modules/services/avahi.nix
          ./modules/services/yt-dlpbot.nix
          #./modules/services/clash-verge.nix
          #./modules/services/code-server.nix
          # desktop 
          inputs.aerothemeplasma-nix.nixosModules.aerothemeplasma-nix
          ./modules/desktop/aerothemeplasma.nix
          copyparty.nixosModules.default
        ({ pkgs, ... }: {
          # add the copyparty overlay to expose the package to the module
          nixpkgs.overlays = [ copyparty.overlays.default ];
          # (optional) install the package globally
          environment.systemPackages = [ pkgs.copyparty ];
          # configure the copyparty module
          services.copyparty.enable = true;
        })
        home-manager.nixosModules.home-manager
        {home-manager.useGlobalPkgs = true;
         home-manager.useUserPackages = true;
         home-manager.users.misha = import ./misha/home.nix;}
        ];
      };
    };
  };
}
