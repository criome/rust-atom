# Modified version of rust-overlay's fromRustupToolchainTomlFile which only supports
# the toml rust-toolchain file - Send upstream?
path:
let
  rust-bin = get.rust-overlay.lib.mkRustBin { } mod.pkgs;
  fileData = mod.readToml path;
in
rust-bin.fromRustupToolchain fileData.toolchain
