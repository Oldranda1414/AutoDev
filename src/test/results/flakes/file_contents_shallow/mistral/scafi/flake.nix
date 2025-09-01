 nix
{ stdenv, sbt }:

stdenv.mkDerivation rec {
  name = "scafi";

  src = ./.;

  buildInputs = [ sbt ];

  phases = "build";

  confs = {
    "development" = (extraArgs: {
      inherit extraArgs stdenv sbt;

      sbt.args.appendExtraOptions "--target", "jvm-2.13";
    });
  };
}
