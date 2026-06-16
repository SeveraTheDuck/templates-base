# -- Checks -------------------------------------------------------------------
# treefmt registers its own `checks.treefmt`. Add spelling and licensing.
# perSystem module.

{ self, pkgs, ... }:
{
  checks = {
    spelling = pkgs.runCommand "typos" { } ''
      ${pkgs.typos}/bin/typos ${self}
      touch $out
    '';

    reuse = pkgs.runCommand "reuse" { } ''
      ${pkgs.reuse}/bin/reuse --root ${self} lint
      touch $out
    '';
  };
}
