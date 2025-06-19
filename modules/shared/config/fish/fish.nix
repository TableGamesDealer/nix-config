{
  config,
  pkgs,
  lib,
  ...
}: {
  enable = true;
  # autosuggestion.enable = true;
  # autocd = false;
  # cdpath = ["~/.local/share/src"];
  #plugins = [];
  shellInit = ''
    # if test -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    #     source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    #     source /nix/var/nix/profiles/default/etc/profile.d/nix.sh
    # end

    # Add to PATH
    set -gx PATH $HOME/.local/share/bin $PATH
    set -gx PATH $HOME/.nix-profile/bin $PATH

    # History ignore is not supported the same way
    # No exact HISTIGNORE equivalent in fish

    # Editor
    set -gx ALTERNATE_EDITOR ""
    set -gx EDITOR "hx"
    set -gx VISUAL "hx"

    # Function
    function shell
        nix-shell '<nixpkgs>' -A $argv[1]
    end


    # Oh My Posh
    oh-my-posh init fish --config ~/.config/oh-my-posh/config.toml | source
  '';
}
