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
  initExtra = ''
    # if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
    #   . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    #   . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
    # fi

    # PATH
    export PATH=$HOME/.local/share/bin:$PATH
    export PATH=$HOME/.nix-profile/bin:$PATH

    # History
    export HISTIGNORE="pwd:ls:cd"

    # Editor
    export ALTERNATE_EDITOR=""
    export EDITOR="hx"
    export VISUAL="hx"

    # Function
    shell() {
      nix-shell '<nixpkgs>' -A "$1"
    }

    # # Alias
    # alias ls='ls --color=auto'

    # Oh My Posh
    eval "$(oh-my-posh init bash --config ~/.config/oh-my-posh/config.toml)"
  '';
}
