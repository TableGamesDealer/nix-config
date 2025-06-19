{
  pkgs,
  config,
  ...
}: let
  githubPublicKey = "ssh-ed25519 ...";
in {
  ".wezterm.lua".source = ./config/wezterm/wezterm.lua;
  ".config/helix/config.toml".source = ./config/helix/config.toml;
  ".config/helix/languages.toml".source = ./config/helix/languages.toml;
  ".config/oh-my-posh/config.toml".source = ./config/oh-my-posh/config.toml;
  ".ssh/id_github.pub" = {
    text = githubPublicKey;
  };
}
