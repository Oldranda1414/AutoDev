{ 
  description = "integration testing";
  inputs = {
    sbtock.url = "https://github.com/typesafehub/sbtock/archive/2.2.0.tar.gz";
    scala.url = "https://scala.zipspringer.com/scalac-2.12.10.zip";
  };
  outputs = [ 
    .shellCommands = pkgs.writeShellScriptBin "develop" ''
      sbt
    '';
  ];