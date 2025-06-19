{
  config,
  pkgs,
  # lib,
  # home-manager,
  ...
}: let
  user = "work";
  # Define the content of your file as a derivation
  # myEmacsLauncher = pkgs.writeScript "emacs-launcher.command" ''
  #   #!/bin/sh
  #   emacsclient -c -n &
  # '';
  sharedFiles = import ../shared/files.nix {inherit config pkgs;};
  additionalFiles = import ./files.nix {inherit user config pkgs;};
in {
  imports = [
    ./dock
  ];

  # It me
  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    brews = ["presenterm" "libiconv"];
    casks = pkgs.callPackage ./casks.nix {};
    # onActivation.cleanup = "uninstall";

    # These app IDs are from using the mas CLI app
    # mas = mac app store
    # https://github.com/mas-cli/mas
    #
    # $ nix shell nixpkgs#mas
    # $ mas search <app name>
    #
    # If you have previously added these apps to your Mac App Store profile (but not installed them on this system),
    # you may receive an error message "Redownload Unavailable with This Apple ID".
    # This message is safe to ignore. (https://github.com/dustinlyons/nixos-config/issues/83)

    masApps = {
      #"1password" = 1333542190;
      #"wireguard" = 1451685025;
    };
  };

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;
    backupFileExtension = "bak";
    users.${user} = {
      pkgs,
      config,
      lib,
      ...
    }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = pkgs.callPackage ./packages.nix {};
        file = lib.mkMerge [
          sharedFiles
          {
            "bin/setup_rustup.sh" = {
              text = ''
                #!/bin/sh
                set -e

                # Explicitly set PATH to include rustup from Nix store
                PATH="${pkgs.rustup}/bin:$PATH"

                # Ensure rustup is available
                if ! command -v rustup >/dev/null 2>&1; then
                  echo "rustup not found in ${pkgs.rustup}/bin. Ensure it is installed via Nix."
                  exit 1
                fi

                # Initialize rustup with stable toolchain if not already set
                echo "Initializing rustup with stable toolchain..."
                ${pkgs.rustup}/bin/rustup toolchain install stable --profile complete || true
                ${pkgs.rustup}/bin/rustup default stable

                # Ensure all required components are installed
                echo "Ensuring Rust components are installed..."
                ${pkgs.rustup}/bin/rustup component add rustc cargo rustfmt clippy rust-docs rust-std rust-analyzer --toolchain stable

                # Verify rust-analyzer is available
                if command -v rust-analyzer >/dev/null 2>&1; then
                  echo "rust-analyzer is installed and ready."
                else
                  echo "Failed to install rust-analyzer. Please check rustup configuration."
                  exit 1
                fi

                if rustup check; then
                  echo updating rustup
                  rustup update stable
                fi
              '';
              executable = true;
            };
          }
        ];

        activation.setupRustup = lib.hm.dag.entryAfter ["writeBoundary"] ''
          $HOME/bin/setup_rustup.sh
        '';

        stateVersion = "23.11";
      };
      programs = {} // import ../shared/home-manager.nix {inherit config pkgs lib;};

      # Marked broken Oct 20, 2022 check later to remove this
      # https://github.com/nix-community/home-manager/issues/3344
      manual.manpages.enable = false;
    };
  };

  # Fully declarative dock using the latest from Nix Store
  local = {
    dock = {
      enable = true;
      # autohide = true;
      username = user;
      entries = [
        {path = "/System/Applications/Messages.app/";}
        {path = "/Applications/Safari.app/";}
        {path = "/Applications/WezTerm.app/";}
        {path = "/Applications/Spotify.app/";}
      ];
    };
  };
}
