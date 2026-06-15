{
  pkgs,
  self,
  pre-commit-hooks,
  treefmtEval,
  lang,
}:

let
  hooks = pre-commit-hooks.lib.${pkgs.stdenv.hostPlatform.system}.run {
    src = self;
    hooks = (import ./hooks.nix { inherit pkgs treefmtEval; }) // (lang.hooks or { });
  };
in
pkgs.mkShell {
  packages =
    (with pkgs; [
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
    ])
    ++ (lang.packages or [ ]);

  shellHook =
    hooks.shellHook
    + (lang.shellHook or "")
    + ''
      echo "dev shell ready — run 'just' to see available recipes"
    '';
}
