{ 
  description = "LLM Introduction";
  inputs = {
    self = {};
  };
  outputs = { self, ... } @ inputs:
    let
      pkgs = import ./pkgs.nix;
    in rec {
      devShell = pkgs.mkShell({
        pname = "llm_intro";
        version = "1.0";
        buildInputs = with pkgs; [
          # Add your dependencies here
          openjdk
          sbt
        ];
      });
    };
}