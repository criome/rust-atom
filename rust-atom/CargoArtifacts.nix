let
  make = name: buildArgs: mod.craneLib.buildDepsOnly buildArgs;

in
std.mapAttrs make mod.src.cratesBuildArgs
