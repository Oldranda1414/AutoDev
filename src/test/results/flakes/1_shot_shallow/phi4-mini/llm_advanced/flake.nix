
{
  description = "Dev environment for AutoDev project";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/unstable";
  };

  outputs = { self , nixpkgs ,... }: let
    system = "x86_64-linux";
  in {
    devShells."${system}".default = pkgs.buildEnv({
      name = "llm-dev-env";

      buildInputs = with pkgs; [
        # used to run LLMs locally (assuming ollama is required for this project)
        nixpkgs.ollama,
        uv,                # modern command runner
        mermaid-cli,
        just,
        scalaJars += curl_jars // Add additional Scala jars if needed
      ];

      shellHook = ''
        echo "Welcome to the AutoDev development environment!"
        source $HOME/.nix-profile/etc/profile.d/auto-dev-env.sh
      '';
    });
  };
}
