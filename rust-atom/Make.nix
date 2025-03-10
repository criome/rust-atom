{
  pkgs ? mod.pkgs,
  crane-lib ? mod.crane-lib,
  src,
  ...
}:
let
  rustToolchainFilePath = (src + "/rust-toolchain.toml");
  hasToolchainFile = std.pathExists rustToolchainFilePath;

  rust-bin = get.rust-overlay.lib.mkRustBin { } pkgs;

  # Modified version of rust-overlay's fromRustupToolchainTomlFile which only supports
  # the toml rust-toolchain file - Send upstream?
  fromRustupToolchainTomlFile =
    path:
    let
      fileData = std.fromTOML (std.readFile path);
    in
    rust-bin.fromRustupToolchain fileData.toolchain;

  customToolchain = fromRustupToolchainTomlFile rustToolchainFilePath;

  customCraneLib = crane-lib.overrideToolchain customToolchain;

  finalCraneLib = if hasToolchainFile then customCraneLib else crane-lib;

  args = { inherit src; };

  cargoArtifacts = finalCraneLib.buildDepsOnly args;

  buildArgs = args // {
    inherit cargoArtifacts;
  };

in
{
  inherit cargoArtifacts;
  package = finalCraneLib.buildPackage buildArgs;
}
