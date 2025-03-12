{
  src,
  ...
}:
let
  craneLib = mod.mkCraneLibFromSrc src;

  crateNamedBuildArgs = mod.mkBuildArgsFromSrc src;

  buildCrateFromNamedData =
    name: buildArgs:
    let
      cargoArtifacts = craneLib.buildDepsOnly buildArgs;

      finalBuildArgs = buildArgs // {
        inherit cargoArtifacts;
      };

    in
    craneLib.buildPackage finalBuildArgs;

in
std.mapAttrs buildCrateFromNamedData crateNamedBuildArgs
