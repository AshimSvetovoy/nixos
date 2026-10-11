# flake.nix
{
  description = "misha nixos";

  inputs = {
    # Use the unstable branch or a specific stable release
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    copyparty.url = "github:9001/copyparty";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, copyparty, home-manager, ... }@inputs: {
    nixosConfigurations = {
      
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
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
          inputs.copyparty.nixosModules.default
          ./modules/services/copyparty.nix
          ./modules/services/firewall.nix
          ./modules/services/avahi.nix
          #./modules/services/pinteresttgbot.nix
          #./modules/services/clash-verge.nix
          #./modules/services/code-server.nix

          # desktop 
          ./modules/desktop/kde.nix

        home-manager.nixosModules.home-manager
        {home-manager.useGlobalPkgs = true;
         home-manager.useUserPackages = true;
         home-manager.users.misha = import ./misha/home.nix;}
        ];
      };
    };
  };
}
