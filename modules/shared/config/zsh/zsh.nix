{
  config,
  pkgs,
  lib,
  ...
}: {
  enable = true;
  autosuggestion.enable = true;
  autocd = false;
  cdpath = ["~/.local/share/src"];
  #plugins = [];
  initContent = ''
    if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
      . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
    fi

    if [ -z "$(ssh-add -l | grep id_ed25519)" ]; then
      ssh-add -q $HOME/.ssh/id_ed25519
    fi

    # Define variables for directories
    export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/lib"
    export PATH=$HOME/.local/share/bin:$PATH
    export PATH=$HOME/.nix-profile/bin:$PATH
    # Remove history data we don't want to see
    export HISTIGNORE="pwd:ls:cd"

    # helix is my editor
    export ALTERNATE_EDITOR=""
    export EDITOR="hx"
    export VISUAL="hx"


    # nix shortcuts
    shell() {
        nix-shell '<nixpkgs>' -A "$1"
    }


    # Always color ls and group directories
    alias ls='ls --color=auto'





    eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/config.toml)"

  '';
}
