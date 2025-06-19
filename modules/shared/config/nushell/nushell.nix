{
  config,
  pkgs,
  lib,
  ...
}: {
  enable = true;
  extraConfig = ''
    # PATH
    # $env.PATH = ($env.PATH | prepend [$env.HOME/.local/share/bin '$env.HOME/.nix-profile/bin'])

    # Editor
    $env.ALTERNATE_EDITOR = ""
    $env.EDITOR = "hx"
    $env.VISUAL = "hx"

    # Function
    def shell [pkg: string] {
      nix-shell '<nixpkgs>' -A $pkg
    }
    oh-my-posh init nu --config ~/.config/oh-my-posh/config.toml
    source ~/.oh-my-posh.nu

  '';
}
