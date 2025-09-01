 
{ pkgs ? import <nixpkgs> {} }

{ stdenv, scala } = pkgs

overrides = {
  models = {
    src = ./.
    build.sbt = self: derivation {
      name = "models";
      src = self.src.main;
      buildInputs = [ scala ];
      buildPhase = ''
        cd ${src} && sbt package
      '';
    };
  }
}

{ config, pkgs }: {
  stdenv.mkDerivation rec {
    name = "models-develop";
    src = ./.;
    buildInputs = [ pkgs.scala ];
    shellHook = ''
      nix develop models --channel https://nixos.org/channels/nixpkgs-${config.system}.channel
    '';
  }
}
