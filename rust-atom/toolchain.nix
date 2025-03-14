let
  rust-bin = get.rust-overlay.lib.mkRustBin { } mod.pkgs;
  inherit (rust-bin.stable.latest) default;

  buildArgs = mod.src.toolchainFileData.toolchain;

  devArgs = buildArgs // {
    components = [ "rust-analyzer" ];
  };

  devFromToolchainFile = rust-bin.fromRustupToolchain devArgs;
  fromToolchainFile = rust-bin.fromRustupToolchain buildArgs;

in
{
  # TODO: default
  dev = devFromToolchainFile;

  build = if mod.src.hasToolchainFile then fromToolchainFile else default;
}
