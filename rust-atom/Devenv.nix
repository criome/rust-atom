{
  packages = [ mod.toolchain.dev ];

  environment = {
    RUST_SRC_PATH = "${mod.toolchain.dev}/lib/rustlib/src/rust/library";
  };

  # TODO
  shell = pkgs.zsh + "/bin/zsh";
}
