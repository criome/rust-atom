let
  cleaned = mod.lib.cleanSourceWith {
    src = get.src;
    filter = mod.crane-lib.filterCargoSources;
  };

  toolchainFilePath = (get.src + "/rust-toolchain.toml");
  isWorkspace = std.hasAttr "workspace" cargoData.root;

  mkMembersCargoData =
    let
      mkNamedMemberData =
        pathString:
        let
          cargoData = mod.readToml "${cleaned}/${pathString}/Cargo.toml";
        in
        {
          inherit (cargoData.package) name;
          value = cargoData;
        };
      mkNamedMembersCargoData = std.map mkNamedMemberData cargoData.root.workspace.members;
    in
    mod.lib.listToAttrs mkNamedMembersCargoData;

  singleMemberCargoData = {
    ${cargoData.root.package.name} = cargoData.root;
  };

  cargoData = {
    root = mod.readToml (get.src + "/Cargo.toml");
    members = if isWorkspace then mkMembersCargoData else singleMemberCargoData;
  };

  mkCrateBuildArgs =
    name: cargoData:
    let
      missingDescriptionWarning = builtins.warn "Missing description in ${name}'s Cargo.toml" "";
    in
    {
      pname = name;
      inherit (cargoData.package) version;
      description = cargoData.package.description or missingDescriptionWarning;
      cargoExtraArgs = "--package ${name}";
      src = cleaned;
    };

in
{
  inherit cleaned cargoData;
  hasToolchainFile = std.pathExists toolchainFilePath;
  toolchainFileData = mod.readToml toolchainFilePath;
  cratesBuildArgs = std.mapAttrs mkCrateBuildArgs cargoData.members;
}
