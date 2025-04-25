{
  crane-lib = get.crane.mkLib pkgs;
  readToml = path: std.fromTOML (std.readFile path);
}
