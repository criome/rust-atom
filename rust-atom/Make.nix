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

  crateNamedBuildArgs = mod.mkBuildArgsFromSrc src;

  buildCrateFromNamedData =
    name: buildArgs:
    let
      cargoArtifacts = finalCraneLib.buildDepsOnly buildArgs;

      finalBuildArgs = buildArgs // {
        inherit cargoArtifacts;
      };

    in
    finalCraneLib.buildPackage finalBuildArgs;

in
std.mapAttrs buildCrateFromNamedData crateNamedBuildArgs
