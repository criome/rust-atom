let
  inherit (get.nixpkgs-atom) pkgs;

in
{
  Pkgs = pkgs;
  Crane-lib = get.crane.mkLib pkgs;
}
