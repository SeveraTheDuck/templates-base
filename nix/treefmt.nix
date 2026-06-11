{ pkgs, ... }:

{
  projectRootFile = "flake.nix";

  settings.global.fail-on-change = true;

  settings.formatter.shfmt = {
    options = [
      "-i"
      "2"
      "-ci"
      "-bn"
      "-w"
    ];
    includes = [
      "*.sh"
      "*.bash"
    ];
  };

  settings.formatter.jq = {
    command = "${pkgs.jq}/bin/jq";
    options = [
      "--indent"
      "2"
      "-S"
      "."
    ];
    includes = [ "*.json" ];
  };

  programs = {
    taplo.enable = true;
    nixfmt.enable = true;
    yamlfmt.enable = true;
    shfmt.enable = true;
  };
}
