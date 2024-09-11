{
  description = "g̶v̶o̶l̶p̶e̶'̶s̶ romek-code's Home Manager & NixOS configurations";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-schemas.url = "github:DeterminateSystems/flake-schemas";

    # https://github.com/NixOS/nixpkgs/commit/c3160517fc6381f86776795e95c97b8ef7b5d2e4
    nixpkgs-mega.url = "nixpkgs/c3160517fc6381f86776795e95c97b8ef7b5d2e4";

    ## nix client with schema support: see https://github.com/NixOS/nix/pull/8892
    nix-schema = {
      inputs.flake-schemas.follows = "flake-schemas";
      url = "github:DeterminateSystems/nix-src/flake-schemas";
    };

    rycee-nurpkgs = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nurpkgs.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # neovim-flake = {
      #url = git+file:///home/gvolpe/workspace/neovim-flake;
      # url = github:gvolpe/neovim-flake;
      # inputs.nixpkgs.follows = "nixpkgs";
      # inputs.flake-schemas.follows = "flake-schemas";
    # };

    # Github Markdown ToC generator

    gh-md-toc = {
      url = "github:ekalinin/github-markdown-toc";
      flake = false;
    };

    # Fast nix search client
    nix-search = {
      url = "github:diamondburned/nix-search";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix linter

    statix = {
      url = "github:nerdypepper/statix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Miscelaneous

    cowsay = {
      url = "github:snowfallorg/cowsay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Firefox style
    penguin-fox = {
      url = "github:p3nguin-kun/penguinFox";
      flake = false;
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1&ref=v0.41.2";
    };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    hyprsplit = {
      url = "github:shezdy/hyprsplit?ref=v0.41.2";
      inputs.hyprland.follows = "hyprland";
    };

    sops-nix.url = "github:Mic92/sops-nix";

    hypr-binds-flake = {
      url = github:gvolpe/hypr-binds;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    let
      system = "x86_64-linux";

      overlays = import ./lib/overlays.nix { inherit inputs system; };

      pkgs = import inputs.nixpkgs {
        inherit overlays system;
        config.allowUnfree = true;
      };
    in
    {
      schemas =
        inputs.flake-schemas.schemas //
        import ./lib/schemas.nix { inherit (inputs) flake-schemas; };

      homeConfigurations = pkgs.mkHomeConfigurations { };
      nixosConfigurations = pkgs.mkNixosConfigurations { };

      out = { inherit pkgs overlays; };

      apps.${system}."nix" = {
        type = "app";
        program = "${pkgs.nix-schema}/bin/nix-schema";
      };

      packages.${system} = {
        inherit (pkgs) bazecor metals metals-updater;
      };
    };
}
