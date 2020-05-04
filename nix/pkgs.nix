# our packages overlay
pkgs: _: with pkgs; let
  naersk = pkgs.callPackage pkgs.commonLib.sources.naersk {};
in {
  kesPackages = naersk.buildPackage {
    root = ../.;
    copyBins = true;
    copyTarget = false;
    copyLibs = true;
  };
}
