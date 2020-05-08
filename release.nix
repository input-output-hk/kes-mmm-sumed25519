let
  stuff = (import ./. {}).pkgs;
  mkArch = f: let
    set = (f stuff);
  in {
    inherit (set) kes_mmm_sumed25519_c;
    simpleHaskellPackages = {
      inherit (set.simpleHaskellPackages) kes-mmm-sumed;
    };
  };
in {
  x86_64-linux = mkArch (x: x);
  raspberryPi = mkArch (x: x.pkgsCross.raspberryPi);
  armv7l-hf-multiplatform = mkArch (x: x.pkgsCross.armv7l-hf-multiplatform);
  aarch64-multiplatform = mkArch (x: x.pkgsCross.aarch64-multiplatform);
  mingwW64 = mkArch (x: x.pkgsCross.mingwW64);
}
