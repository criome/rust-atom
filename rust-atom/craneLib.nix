let
  customCraneLib = mod.crane-lib.overrideToolchain mod.rustToolchain;
in
if mod.src.hasToolchainFile then customCraneLib else mod.crane-lib
