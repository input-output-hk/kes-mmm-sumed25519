{ rustPlatform
, fetchFromGitHub
, pkgconfig
, stdenv
, darwin
,  ... }:

let
  Security = darwin.apple_sdk.frameworks.Security;
in rustPlatform.buildRustPackage rec {
  version = "0.0";
  name = "cardano-http-bridge-${version}";
  src = ../kes-mmm-sumed25519;
  preConfigure = ''
    export HOME=`mktemp -d`
  '';
}
