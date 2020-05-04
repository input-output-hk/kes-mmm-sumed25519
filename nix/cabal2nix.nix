self: super: {
  simpleHaskellPackages = self.haskellPackages.extend (hself: hsuper: {
    kes-mmm-sumed = hself.callCabal2nix "kes-mmm-sumed" ../kes-mmm-sumed25519-hs {};
  });
}
