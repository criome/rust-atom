{
  description = "rust-atom";

  inputs = {
    make-atom.url = "github:criome/make-atom/testing";

    system.url = "github:criome/system";

    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs-lib.flake = false;

    src.url = "github:superatomic/xshe";
    src.flake = false;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    crane.url = "github:ipetkov/crane";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    inputs.make-atom.mkAtom {
      args.atomSrc = ./.;
      args.atomName = "rust-atom";

      system = inputs.system.value;

      local-registry = {
        inherit (inputs)
          nixpkgs
          nixpkgs-lib
          crane
          rust-overlay
          ;
      };
    };
}
