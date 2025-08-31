
build:
    with stdenv;

    source (
        inherit stdenv.mkDerivation;

        importPackages += ['org.scalatest' % "scalatest" % "3.2.12"];
    ) nixos-dev.scm
