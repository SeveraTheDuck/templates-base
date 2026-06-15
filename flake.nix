{
  description = "templates-base: Opinionated base template for production-ready pet projects";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      treefmt-nix,
      pre-commit-hooks,
      ...
    }:
    let
      lib = nixpkgs.lib;

      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forEachSystem = lib.genAttrs systems;

      # -- Optional language layer ---------------------------------------------
      # A language template (e.g. templates-lang-cpp) drops `nix/lang.nix`.
      # Base picks it up automatically; nothing here is edited per-language.
      langPath = ./nix/lang.nix;
      hasLang = builtins.pathExists langPath;

      langFor =
        pkgs:
        if hasLang then
          import langPath { inherit pkgs lib self; }
        else
          {
            packages = [ ];
            treefmt = { };
            hooks = { };
            checks = { };
            shellHook = "";
          };

      treefmtEvalFor =
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
          lang = langFor pkgs;
        in
        treefmt-nix.lib.evalModule pkgs {
          imports = [ (import ./nix/treefmt.nix) ] ++ lib.optional hasLang lang.treefmt;
        };
    in
    {
      devShells = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = import ./nix/shell.nix {
            inherit pkgs self pre-commit-hooks;
            treefmtEval = treefmtEvalFor system;
            lang = langFor pkgs;
          };
        }
      );

      formatter = forEachSystem (system: (treefmtEvalFor system).config.build.wrapper);

      checks = forEachSystem (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        import ./nix/checks.nix {
          inherit pkgs self;
          treefmtEval = treefmtEvalFor system;
          lang = langFor pkgs;
        }
      );
    };
}
