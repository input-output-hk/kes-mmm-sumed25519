# our packages overlay
pkgs: _: with pkgs; let
  naersk = pkgs.callPackage pkgs.commonLib.sources.naersk {};
  filter = name: type: let
    baseName = baseNameOf (toString name);
    sansPrefix = lib.removePrefix (toString ../.) name;
  in
    (type == "directory") ||
    (lib.hasSuffix ".rs" name) ||
    (baseName == "Cargo.lock") ||
    (baseName == "Cargo.toml");
  src = lib.cleanSourceWith {
    inherit filter;
    src = ../.;
    name = "kes-mmm-sumed25519";
  };
in {
  kes_mmm_sumed25519_c = naersk.buildPackage {
    root = ../.;
    copyBins = true;
    copyTarget = false;
    copyLibs = true;
  };
}
