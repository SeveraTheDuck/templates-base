{ pkgs, ... }:

{
  settings.global.fail-on-change = true;

  programs = {
    # TOML
    taplo.enable = true;

    # Shell
    shfmt = {
      enable = true;
      # -i 2: 2-space indent; -ci: indent switch cases; -bn: binary ops on new line
      options = [ "-i 2" "-ci" "-bn" ];
    };

    # Nix
    nixfmt.enable = true;

    # YAML
    yamlfmt.enable = true;

    # JSON
    jq = {
      enable = true;
      includes = [ "*.json" ];
    };
  };
}
