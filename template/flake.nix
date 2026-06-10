{
  description = "{{project_name}}: {{project_description}}";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs =
    {
      self,
      nixpkgs,
      devenv,
      treefmt-nix,
      ...
    }@inputs:
    let
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSystem = nixpkgs.lib.genAttrs systems;

      treefmtEvalFor = system:
        treefmt-nix.lib.evalConfig
          nixpkgs.legacyPackages.${system}
          (import ./nix/treefmt.nix);
    in
    {
      devShells = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = devenv.lib.mkShell {
            inherit inputs pkgs;
            modules = [ (import ./nix/devenv.nix) ];
          };
        }
      );

      formatter = forEachSystem (
        system: (treefmtEvalFor system).config.build.wrapper
      );

      checks = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          formatting = (treefmtEvalFor system).config.build.check self;
          spelling = pkgs.runCommand "typos" {} ''
            ${pkgs.typos}/bin/typos ${self}
            touch $out
          '';
        }
      );
    };
}
