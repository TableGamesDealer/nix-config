{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "Your Name";
  user = "user";
  email = "your.email@example.com";
in {
  # Shared shell configuration
  zsh = import ./config/zsh/zsh.nix {inherit config pkgs lib;};
  bash = import ./config/bash/bash.nix {inherit config pkgs lib;};
  fish = import ./config/fish/fish.nix {inherit config pkgs lib;};
  nushell = import ./config/nushell/nushell.nix {inherit config pkgs lib;};
  git = import ./config/git/git.nix {inherit config pkgs lib name email;};
  zoxide = import ./config/zoxide/zoxide.nix {inherit config pkgs lib;};
  # helix = import ./config/helix/helix.nix {inherit config pkgs lib;};
  ssh = import ./config/ssh/ssh.nix {inherit config pkgs lib user;};
  oh-my-posh = {
    enable = true;
    useTheme = "velvet";
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;
  };
}
