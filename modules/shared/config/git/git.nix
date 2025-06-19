{
  config,
  pkgs,
  lib,
  name,
  email,
  ...
}: {
  enable = true;
  ignores = ["*.swp"];
  userName = name;
  userEmail = email;
  lfs = {
    enable = true;
  };
  extraConfig = {
    init.defaultBranch = "main";
    core = {
      editor = "hx";
      autocrlf = "input";
    };
    # commit.gpgsign = true;
    pull.rebase = true;
    rebase.autoStash = true;
    push.autoSetupRemote = true;
    credential.helper = "osxkeychain";
  };
}
