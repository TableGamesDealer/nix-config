{
  agenix,
  config,
  pkgs,
  ...
}: let
  user = "work";
in {
  imports = [
    ../../modules/darwin/secrets.nix
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
    agenix.darwinModules.default
  ];

  # Setup user, packages, programs
  nix = {
    package = pkgs.nix;

    settings = {
      trusted-users = ["@admin" "${user}"];
      substituters = ["https://nix-community.cachix.org" "https://cache.nixos.org"];
      trusted-public-keys = ["cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="];
    };

    gc = {
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs;
    [
      agenix.packages."${pkgs.system}".default
    ]
    ++ (import ../../modules/shared/packages.nix {inherit pkgs;});

  system = {
    checks.verifyNixPath = false;
    primaryUser = user;
    stateVersion = 4;

    defaults = {
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        AppleShowAllFiles = true;
        AppleScrollerPagingBehavior = true;
        AppleShowScrollBars = "Automatic";
        # NSGlobalDomain = {
        #   ShowPathBar = true;
        #   ShowStatusBar = true;
        # };
        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;

        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };

      controlcenter = {
        BatteryShowPercentage = true;
      };

      finder = {
        NewWindowTarget = "Other";
        NewWindowTargetPath = "${config.users.users.work.home}";
        ShowStatusBar = true;
        ShowPathbar = true;
        QuitMenuItem = true;
        FXPreferredViewStyle = "Nlsv";
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
        CreateDesktop = false;
      };

      dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "left";
        tilesize = 48;
        wvous-tr-corner = 13;
        wvous-tl-corner = 1;
        wvous-br-corner = 1;
        wvous-bl-corner = 1;
        static-only = false;
        showhidden = true;
      };

      finder = {
        _FXShowPosixPathInTitle = true;
      };

      trackpad = {
        Clicking = true;
        ActuationStrength = 0;
        TrackpadThreeFingerDrag = true;
      };
    };
  };
}
