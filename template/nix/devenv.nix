{ pkgs, ... }:

{
  # --- Packages ---------------------------------------------------------------
  packages = with pkgs; [
    just
    typos
    reuse
    commitlint-rs

    treefmt
    taplo
    shfmt
    nixfmt
    yamlfmt
    jq
  ];

  # --- Pre-commit hooks -------------------------------------------------------
  git-hooks.hooks = {
    treefmt.enable = true;
    typos.enable = true;

    commitlint = {
      enable = true;
      name = "commitlint";
      description = "Lint commit message";
      entry = "${pkgs.commitlint-rs}/bin/commitlint --edit";
      stages = [ "commit-msg" ];
    };
  };

  # --- Shell ------------------------------------------------------------------
  enterShell = ''
    echo "devenv ready — run 'just' to see available recipes"
  '';
}
