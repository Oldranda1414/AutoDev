 
{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
  };

  outputs = self: let
    system = "x86_64-linux";
    git = import nixpkgs.lib.git {
      url = "https://github.com/<username>/AutoDev.git";
      rev = "xxxxxxxxx"; # replace with the appropriate commit hash or branch name
    };
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      name = "llm_intro-dev";
      buildInputs = [
        ollama
        uv
        mermaid-cli
        just
      ];
      shellHook = ''
        cd ${gitOut}/src/test/space/llm_intro && git checkout $rev;
        mkdir -p $out && cp -R ${gitOut}/src $out;
        cd $out/src && sbt compile;
      '';
    };
  };
}
