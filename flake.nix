{
  description = "My NixOs flake configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
     url = "github:nix-community/home-manager";
     inputs.nixpkgs.follows = "nixpkgs";
    };
    auto-cpufreq = {
            url = "github:adnanhodzic/auto-cpufreq";
            inputs.nixpkgs.follows = "nixpkgs";
     };
    plugin-onedark.url = "github:navarasu/onedark.nvim";
    plugin-onedark.flake = false;
   hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@inputs: 
   let
	system = "x86_64-linux";
 	
	pkgs = import nixpkgs {
	  inherit system;
	  config = {
	   allowUnfree = true;
	  };
	};
  in
  {
  nixosConfigurations = {
    myNixos = nixpkgs.lib.nixosSystem{
    specialArgs = { inherit inputs system; };
    modules = [
	./nixos/configuration.nix
	
	];
	};
  };



  
    

  };
}
