{
  pkgs,
  self,
  treefmtEval,
  lang,
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
// (lang.checks or { })
