{
  description = "rust-atom";

  inputs = {
    make-atom.url = "github:criome/make-atom/testing";
    make-atom.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    system.url = "github:criome/system";

    src.url = "github:criome/horizon-rs/testing";
    src.flake = false;

    crane.url = "github:ipetkov/crane";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: inputs.make-atom.mkAtomFlake ./. inputs;
}
