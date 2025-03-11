{
  src,
  ...
}:
let
  rustToolchainFilePath = (src + "/rust-toolchain.toml");
  hasToolchainFile = std.pathExists rustToolchainFilePath;

  customToolchain = mod.mkRustupToolchainTomlFile rustToolchainFilePath;

  customCraneLib = mod.crane-lib.overrideToolchain customToolchain;

  finalCraneLib = if hasToolchainFile then customCraneLib else mod.crane-lib;

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
