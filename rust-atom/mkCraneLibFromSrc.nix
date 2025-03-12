src:
let
  rustToolchainFilePath = (src + "/rust-toolchain.toml");
  hasToolchainFile = std.pathExists rustToolchainFilePath;
  customToolchain = mod.mkRustupToolchainTomlFile rustToolchainFilePath;
  customCraneLib = mod.crane-lib.overrideToolchain customToolchain;
in
if hasToolchainFile then customCraneLib else mod.crane-lib
