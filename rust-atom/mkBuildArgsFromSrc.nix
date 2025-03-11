unfilteredSrc:
let
  mainCargoData = mod.readToml (unfilteredSrc + "/Cargo.toml");

  src = mod.lib.cleanSourceWith {
    src = unfilteredSrc;
    filter = mod.crane-lib.filterCargoSources;
  };

  srcIsWorkspace = std.hasAttr "workspace" mainCargoData;

  mkCrateBuildArgs =
    cargoData:
    let
      inherit (cargoData.package) name version;
      missingDescriptionWarning = builtins.warn "Missing description in ${name}'s Cargo.toml" "";
    in
    {
      pname = name;
      description = cargoData.package.description or missingDescriptionWarning;
      cargoExtraArgs = "--package ${name}";
      inherit
        src
        version
        ;
    };

  accumulateMembers =
    acc: pathString:
    let
      cargoData = mod.readToml "${src}/${pathString}/Cargo.toml";
      inherit (cargoData.package) name;
      buildArgs = mkCrateBuildArgs cargoData;
    in
    acc // { ${name} = buildArgs; };

  membersData = builtins.foldl' accumulateMembers { } mainCargoData.workspace.members;

  singleData = {
    ${mainCargoData.package.name} = mkCrateBuildArgs mainCargoData;
  };

in
if srcIsWorkspace then membersData else singleData
