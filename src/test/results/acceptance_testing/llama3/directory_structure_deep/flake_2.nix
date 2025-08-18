{ 
  outputs = [ dev ]; 
  inputs = [ ./. ]; 
  default = builtins.callPackage ./flake {};

  dev = pkgs.mkDerivation {
    name = "acceptance-testing";
    builder = builtins.getshellCommand ''
      cd acceptance_testing
      sbt
    '';
    propagatedBuildInputs = [ pkgs.sbtoverride ];
  };
}