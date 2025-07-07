{
  description = "Always-latest GTK theme bundle (Fausto, Vince, Orchis, Kanagawa, Juno Mirage, Rose-Pine)";

  inputs = {
    nixpkgs.url            = "github:NixOS/nixpkgs/nixos-unstable";

    # Fausto themes
    catppuccin-theme.url    = "github:jaycee1285/Catppuccin-GTK-Theme";
    gruvbox-theme.url       = "github:jaycee1285/Gruvbox-GTK-Theme";
    everforest-theme.url    = "github:jaycee1285/Everforest-GTK-Theme";
    tokyonight-theme.url    = "github:jaycee1285/Tokyonight-GTK-Theme";
    osaka-theme.url         = "github:jaycee1285/Osaka-GTK-Theme";

    # Kanagawa
    kanagawa-theme.url      = "github:jaycee1285/Kanagawa-GTK-Theme";

    # Nordfox
    nordfox-theme.url       = "github:jaycee1285/Nightfox-GTK-Theme";

    # Eliver
    orchis-theme.url        = "github:jaycee1285/Orchis-theme";

    # Vince themes
    nordic-polar-theme.url  = "github:jaycee1285/Nordic-Polar";

    # Rose-Pine
    rose-pine-theme.url     = "github:jaycee1285/Rose-Pine-GTK-Theme";
  };

  outputs = { self, nixpkgs , catppuccin-theme, gruvbox-theme, everforest-theme,
              tokyonight-theme, osaka-theme, kanagawa-theme, nordfox-theme,
              orchis-theme, nordic-polar-theme, rose-pine-theme, ... }:
  let
    system = "x86_64-linux";
    pkgs   = import nixpkgs { inherit system; };

    makeTheme = { pname, src, style, themeFolder ? null, installFlags ? "",
                  nativeBuildInputs ? [ pkgs.gtk3 pkgs.sassc ],
                  buildInputs ? [], propagatedUserEnvPkgs ? [], meta ? {} }:
      pkgs.stdenvNoCC.mkDerivation {
        inherit pname nativeBuildInputs buildInputs propagatedUserEnvPkgs meta;
        src     = src;
        version = "unstable-latest";

        installPhase =
          (pkgs.lib.optionalString (style == "fausto") ''
            cd themes
            bash ./install.sh ${installFlags} -d $out/share/themes
          '') +
          (pkgs.lib.optionalString (style == "eliver") ''
            bash ./install.sh ${installFlags} -d $out/share/themes
          '') +
          (pkgs.lib.optionalString (style == "vince" && themeFolder != null) ''
            mkdir -p $out/share/themes/${themeFolder}
            shopt -s dotglob
            dir=$(find . -maxdepth 1 -type d ! -name '.' | head -n1)
            cp -r "$dir"/* $out/share/themes/${themeFolder}/
            shopt -u dotglob
          '');
      };

  in {
    packages.${system} = {
      # Catppuccin
      catppuccin-gtk-theme = makeTheme {
        pname                 = "catppuccin-gtk-theme";
        src                   = catppuccin-theme;
        style                 = "fausto";
        themeFolder           = "Catppuccin-gtk-theme";
        installFlags          = "--tweaks outline";
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Catppuccin GTK theme (Fausto, always latest)";
          homepage    = "https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Gruvbox
      gruvbox-gtk-theme = makeTheme {
        pname                 = "gruvbox-gtk-theme";
        src                   = gruvbox-theme;
        style                 = "fausto";
        themeFolder           = "Gruvbox-gtk-theme";
        installFlags          = "-t orange --tweaks outline";
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Gruvbox GTK theme (Fausto, always latest)";
          homepage    = "https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Everforest
      everforest-gtk-theme = makeTheme {
        pname                 = "everforest-gtk-theme";
        src                   = everforest-theme;
        style                 = "fausto";
        themeFolder           = "Everforest-gtk-theme";
        installFlags          = "-t grey --tweaks outline";
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Everforest GTK theme (Fausto, always latest)";
          homepage    = "https://github.com/Fausto-Korpsvart/Everforest-GTK-Theme";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Tokyonight
      tokyonight-gtk-theme = makeTheme {
        pname                 = "tokyonight-gtk-theme";
        src                   = tokyonight-theme;
        style                 = "fausto";
        themeFolder           = "Tokyonight-gtk-theme";
        installFlags          = "--tweaks outline storm";
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Tokyonight GTK theme (Fausto, always latest)";
          homepage    = "https://github.com/Fausto-Korpsvart/Tokyonight-GTK-Theme";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Osaka
      osaka-gtk-theme = makeTheme {
        pname                 = "osaka-gtk-theme";
        src                   = osaka-theme;
        style                 = "fausto";
        themeFolder           = "Osaka-gtk-theme";
        installFlags          = "--tweaks outline solarized";
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Osaka GTK theme (Fausto, always latest)";
          homepage    = "https://github.com/Fausto-Korpsvart/Osaka-GTK-Theme";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Kanagawa
      kanagawa-gtk-theme = makeTheme {
        pname                 = "kanagawa-gtk-theme";
        src                   = kanagawa-theme;
        style                 = "fausto";
        themeFolder           = "Kanagawa-gtk-theme";
        installFlags          = "-s compact --tweaks dragon outline";
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Kanagawa GTK theme (Fausto, always latest)";
          homepage    = "https://github.com/Fausto-Korpsvart/Kanagawa-GTK-Theme";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Orchis
      orchis-orange-compact = makeTheme {
        pname                 = "orchis-orange-compact";
        src                   = orchis-theme;
        style                 = "eliver";
        themeFolder           = "Orchis-orange-compact";
        installFlags          = "-t orange -c light --tweaks compact";
        buildInputs           = [ pkgs.gnome-themes-extra ];
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Orchis GTK theme (orange, compact, always latest)";
          homepage    = "https://github.com/vinceliuice/Orchis-theme";
          license     = licenses.gpl3Plus;
          platforms   = platforms.linux;
        };
      };

      # Nordic Polar
      nordic-polar-gtk-theme = pkgs.stdenvNoCC.mkDerivation rec {
        pname     = "nordic-polar-gtk-theme";
        version   = "2.2.0-unstable-2025-03-21";
        src       = pkgs.fetchFromGitHub {
          owner = "EliverLara";
          repo  = "Nordic-Polar";
          rev   = "ca23b9460713e72defae777162175921beae6e27";
          hash  = "sha256-wkmmpviQBGoE/+/tPTIIgkWFUYtYney5Yz12m8Zlak8=";
        };
        propagatedUserEnvPkgs  = [ pkgs.gtk-engine-murrine ];
        nativeBuildInputs      = [ pkgs.jdupes ];
        dontCheckForBrokenSymlinks = true;
        installPhase = ''
          mkdir -p $out/share/themes/Nordic-Polar-standard-buttons
          cp -a ./* $out/share/themes/Nordic-Polar-standard-buttons/
          rm -rf {LICENSE,README.md,.gitignore,Art,FUNDING.yml,package.json,Gulpfile.js,src,**/*.scss}
          jdupes --quiet --link-soft --recurse $out/share/themes/Nordic-Polar-standard-buttons || true
        '';
        meta = with pkgs.lib; {
          description = "Nordic Polar GTK theme (standard buttons variant only)";
          homepage    = "https://github.com/EliverLara/Nordic-Polar";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Juno Mirage
      juno-mirage-gtk-theme = pkgs.stdenvNoCC.mkDerivation rec {
        pname     = "juno-mirage-gtk-theme";
        version   = "0.0.2";
        src       = pkgs.fetchurl {
          url    = "https://github.com/gvolpe/Juno/releases/download/${version}/Juno-mirage-standard-buttons.tar.xz";
          sha256 = "EQmIOJeooOYrc74UfTq0z/51FHd6/QzN5+Ga56j3l6M=";
        };
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        unpackPhase = '' tar xf $src '';
        installPhase = ''
          mkdir -p $out/share/themes/Juno-mirage-standard-buttons
          cp -a Juno-mirage-standard-buttons/* $out/share/themes/Juno-mirage-standard-buttons/
          rm -f $out/share/themes/Juno-mirage-standard-buttons/{LICENSE,README.md}
        '';
        meta = with pkgs.lib; {
          description = "Juno Mirage GTK theme (standard buttons, official)";
          homepage    = "https://github.com/gvolpe/Juno";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Nordfox
      nordfox-gtk-theme = makeTheme {
        pname                 = "nordfox-gtk-theme";
        src                   = nordfox-theme;
        style                 = "fausto";
        themeFolder           = "Nordfox-gtk-theme";
        installFlags          = "-s compact --tweaks outline nord";
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Nordfox GTK theme (Fausto, always latest)";
          homepage    = "https://github.com/jaycee1285/Nightfox-GTK-Theme";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };

      # Rose-Pine
      rose-pine-gtk-theme = makeTheme {
        pname                 = "rose-pine-gtk-theme";
        src                   = rose-pine-theme;
        style                 = "fausto";
        themeFolder           = "Rose-Pine-gtk-theme";
        installFlags          = "--tweaks moon outline";
        propagatedUserEnvPkgs = [ pkgs.gtk-engine-murrine ];
        meta = with pkgs.lib; {
          description = "Rose-Pine GTK theme (Fausto, always latest)";
          homepage    = "https://github.com/jaycee1285/Rose-Pine-GTK-Theme";
          license     = licenses.gpl3Only;
          platforms   = platforms.linux;
        };
      };
    };
  };
}
