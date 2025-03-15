{
  description = "rust-atom";

  inputs = {
    atom.url = "github:LiGoldragon/atom/atomicFlake-v1";
    system.url = "github:criome/system";

    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    nixpkgs-lib.flake = false;

    src.url = "github:criome/horizons-rs";
    src.flake = false;

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    crane.url = "github:ipetkov/crane";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: inputs.atom.mkAtomicFlake inputs (./. + "/rust-atom@.toml");
}
