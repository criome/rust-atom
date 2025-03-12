let
  make =
    name: buildArgs:
    let
      finalBuildArgs = buildArgs // {
        cargoArtifacts = mod.cargoArtifacts.${name};
      };
    in
    mod.craneLib.buildPackage finalBuildArgs;

in
std.mapAttrs make mod.src.cratesBuildArgs
