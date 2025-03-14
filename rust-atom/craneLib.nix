let
  customCraneLib = mod.crane-lib.overrideToolchain mod.toolchain.build;
in
if mod.src.hasToolchainFile then customCraneLib else mod.crane-lib
