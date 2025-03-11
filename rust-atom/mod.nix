let
  inherit (get.nixpkgs-atom) pkgs lib;
in
{
  inherit pkgs lib;
  crane-lib = get.crane.mkLib pkgs;
  readToml = path: std.fromTOML (std.readFile path);
}
