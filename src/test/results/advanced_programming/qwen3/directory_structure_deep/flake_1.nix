

{
  outputs = {
    self, nixpkgs, scala, sbt: {
      devShell = {
        buildInputs = [ scala sbt ];
        shellHook = ''
          cd /home/randa/AutoDev/src/test/space/advanced_programming
          sbt
        '';
      };
    };
  };
}