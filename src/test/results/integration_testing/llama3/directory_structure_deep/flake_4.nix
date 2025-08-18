{ 
  description = "Dev Environment for Integration Testing";
  inputs = {
    nixpkgs = builtins.fetchTarball https://github.com/nixos/nixpkgs/archive/master.tar.gz;
    scala = self.callPackage ./scala {};
    sbt = self.callPackage ./sbt {};
  };
  outputs = { self, nixpkgs, scala, sbt ->
    let 
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      build = pkgs.buildinstantiate {
        name = "dev-env";
        builder = pkgs.scala /bin/scalac -cp ${build}/target/scala-2.13/classes;
      };
    in
    {
      dev-shell = self.shellsTree {
        shellHook = ''source $REPO_DIR/integration_testing/.nix-profile/etc/profile.d/init.sh'';
      };
    };
}