{ 
  outputs = { self, nixpkgs }: 

  let 
    pkgs = import nixpkgs;
    projectRoot = ./..;
    modelsDir = "${projectRoot}/models";
    srcDir = "${projectRoot}/src";
    testDir = "${projectRoot}/test";
  
  in 
  
  {
    devShells = { pkgs: rec {
      default = pkgs.vim;
    }; }
    
  , 
  packages = pkgs.stdenv.mkDerivation {
    name = "my-project";
    buildInputs = [ pkgs.sbtock ];
    postBuild = ''
      sbt
    '';
  };
}