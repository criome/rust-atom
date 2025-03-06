atom@{
  pkgs ? mod.pkgs,
  crane-lib ? mod.pkgs,
}:
let
  package = crane-lib.build;

in
{ }
