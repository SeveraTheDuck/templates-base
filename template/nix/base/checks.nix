# -- Checks -------------------------------------------------------------------
# treefmt registers its own `checks.treefmt`. Add spelling and licensing.
# perSystem module.

{ inputs, pkgs, ... }:
{
  checks = {
    spelling = pkgs.runCommand "typos" { } ''
      ${pkgs.typos}/bin/typos ${inputs.self}
      touch $out
    '';

    reuse = pkgs.runCommand "reuse" { } ''
      ${pkgs.reuse}/bin/reuse --root ${inputs.self} lint
      touch $out
    '';
  };
}
