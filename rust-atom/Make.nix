{
  pkgs ? mod.pkgs,
  crane-lib ? mod.crane-lib,
  src,
  ...
}:
let
  args = { inherit src; };

  cargoArtifacts = crane-lib.buildDepsOnly args;

  buildArgs = args // {
    inherit cargoArtifacts;
  };

in
{
  inherit cargoArtifacts;
  package = crane-lib.buildPackage buildArgs;
}
