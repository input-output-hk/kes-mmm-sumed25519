let
  self = import ../. {};
in self.pkgs.simpleHaskellPackages.kes-mmm-sumed.env.overrideAttrs (old: {
  buildInputs = old.buildInputs ++ [ self.pkgs.kes_mmm_sumed25519_c ];
  shellHook = ''
    export LD_LIBRARY_PATH=${self.pkgs.kes_mmm_sumed25519_c}/lib
    echo "build with: runhaskell Setup.hs configure && runhaskell Setup.hs build"
    echo "repl with: runhaskell Setup.hs configure && runhaskell Setup.hs repl kes-mmm-sumed"
    echo "or use stack with: stack --system-ghc --no-nix ghci"
  '';
})
