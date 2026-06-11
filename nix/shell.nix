{
  pkgs,
  self,
  pre-commit-hooks,
  treefmtEval,
}:

let
  hooks = pre-commit-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
    src = self;
    hooks = import ./hooks.nix { inherit pkgs treefmtEval; };
  };
in
pkgs.mkShell {
  packages = with pkgs; [
    just
    typos
    reuse
    commitlint-rs

    treefmtEval.config.build.wrapper
    taplo
    shfmt
    nixfmt
    yamlfmt
    jq
  ];

  shellHook = hooks.shellHook + ''
    echo "devenv ready — run 'just' to see available recipes"
  '';
}
