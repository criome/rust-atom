{
  Pkgs = get.nixpkgs-atom.pkgs;
  Crane-lib = get.crane.mkLib pkgs;
  MkAtom = mod.mkRustAtom;
}
