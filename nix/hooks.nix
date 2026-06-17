{ pkgs, treefmtEval }:

{
  treefmt = {
    enable = true;
    package = treefmtEval.config.build.wrapper;
  };

  typos.enable = true;

  reuse = {
    enable = true;
    name = "reuse";
    description = "Check REUSE license compliance";
    entry = "${pkgs.reuse}/bin/reuse lint";
    pass_filenames = false;
  };

  commitlint = {
    enable = true;
    name = "commitlint";
    description = "Lint commit message";
    entry = "${pkgs.commitlint-rs}/bin/commitlint --edit";
    stages = [ "commit-msg" ];
  };
}
