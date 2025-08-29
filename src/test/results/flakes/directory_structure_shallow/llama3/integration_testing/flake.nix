{ 
  description = "integration testing"; 
  inputs = { scala = fetchurl { url = "https://github.com/scala/scala.git"; }; };
  outputs = { self, nixpkgs }: 
    let 
      pkgs = nixpkgs.legacyPackages.x86_64;
      shellHook = ''
        ${pkgs.coreutils}/bin/ln -sfnT $(realpath ./integration_testing/build.sbt) $HOME/.nix-profile/share/home
      '';
    in 
    {
      devShell = pkgs.mkShell {
        buildInputs = [ scala ];
        shellHook = shellHook;
      };
      defaultPackage = self.devShell;
    };