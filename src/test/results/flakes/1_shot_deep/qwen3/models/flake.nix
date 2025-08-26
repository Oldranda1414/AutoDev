

{
  system = "x86_64-linux";
  inputs = {
    scala = {
      url = "github:scala/scala";
      flake = true;
    };
    sbt = {
      url = "github:sbt/sbt";
      flake = true;
    };
  };
  outputs = { self, scala, sbt }: {
    devShell = {
      nativeBuildInputs = [ scala.sbtopts sbt ];
      shellHook = ''
        export PATH=$PATH:$HOME/.sbt/boot
        export PATH=$PATH:$HOME/.ivy2/bin
      '';
    };
  };
}