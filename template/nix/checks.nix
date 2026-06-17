{
  pkgs,
  self,
  treefmtEval,
}:

{
  formatting = treefmtEval.config.build.check self;

  spelling = pkgs.runCommand "typos" { } ''
    ${pkgs.typos}/bin/typos ${self}
    touch $out
  '';

  reuse = pkgs.runCommand "reuse" { } ''
    ${pkgs.reuse}/bin/reuse --root ${self} lint
    touch $out
  '';
}
