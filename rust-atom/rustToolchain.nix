let
  rust-bin = get.rust-overlay.lib.mkRustBin { } mod.pkgs;
  inherit (rust-bin.stable.latest) default;
  fromToolchainFile = rust-bin.fromRustupToolchain mod.src.toolchainFileData.toolchain;
in
if mod.src.hasToolchainFile then fromToolchainFile else default
