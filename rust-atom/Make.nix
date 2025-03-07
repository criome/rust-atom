atom@{
  pkgs ? mod.pkgs,
  crane-lib ? mod.crane-lib,
  src,
  ...
}:
let
  args = { inherit src; };

  cargoArtifacts = crane-lib.buildDepsOnly args;

  buildArgs = { inherit cargoArtifacts; };

  package = crane-lib.buildPackage buildArgs;

in
{
  inherit cargoArtifacts package;
}
