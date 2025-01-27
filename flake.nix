{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";


    dotfiles = {
      url = "github:fpiribauer/dotfiles";
      flake = false;
    };

    nix-colors.url = "github:misterio77/nix-colors";

    stylix.url = "github:danth/stylix";

    nixvim = {
        url = "github:jiricmi/nixvim";
    };
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/laptop/configuration.nix
	  {
            imports = [ home-manager.nixosModules.home-manager ];
          }
        ];
      };
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
	system = "x86_64-linux";
        modules = [
          ./hosts/desktop/configuration.nix
	  {
            imports = [ home-manager.nixosModules.home-manager ];
          }
        ];
      };
    };
  };
}
