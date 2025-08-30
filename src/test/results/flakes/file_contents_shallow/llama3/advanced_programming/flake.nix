{ description = "Advanced Programming Project";

inputs = {
  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/nixos/nixpkgs";
  };
  sbt = nixpkgs.fetchurl {
    url = "https://binaries.scala-sbt.org/en/1.9.9/sbt-1.9.9.jar";
    sha256 = "0x5d4b6d2e93f3a8f0dd7f94ee88c9cbe9b0f43a4a55af77f4cd52e53f44db7c1";
  };
};

outputs = [ (nixpkgs.rolling-release) ];

flake = { 
  name = "advanced_programming"; 
  outputs = [ "out" ]; 
}; 

project = flake;
buildInputs = [ sbt ];
 platforms = [ pkgs.linux ];
shellHook = ''
  source $HOME/.sbt/sbtlast
'';

}