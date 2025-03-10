{
  description = "rust-atom";

  inputs = {
    atom.url = "github:LiGoldragon/atom/atomicFlake-v1";
    system.url = "github:criome/system";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-atom.url = "github:criome/nixpkgs-atom";
    nixpkgs-atom.inputs.nixpkgs.follows = "nixpkgs";

    crane.url = "github:ipetkov/crane";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs: inputs.atom.mkAtomicFlake inputs (./. + "/rust-atom@.toml");
}
