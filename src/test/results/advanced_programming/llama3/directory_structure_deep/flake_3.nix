{ description = "Advanced Programming Project";

outputs = { self, nixpkgs }: rec {

  devShell = pkgs: let
      inherit (nixpkgs.legacyPackages) scala sbt;
    in pkgs.mkshell {
      packages = [ scala scala.compile );
    };
}; }