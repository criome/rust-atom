{
  description = "rust-atom";

  inputs = {
    atom.url = "github:LiGoldragon/atom";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixpkgs-atom.url = "github:criome/nixpkgs-atom";
    nixpkgs-atom.inputs.nixpkgs.follows = "nixpkgs";

    crane.url = "github:ipetkov/crane";
  };

  outputs = inputs: inputs.atom.mkAtomicFlake inputs (./. + "/rust-atom@.toml");
}
