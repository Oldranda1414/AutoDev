nixos
{ pkgs }:

let
    oss-dev-langchain4j = import (head nixPath / github ? (import "${builtins.fetch}(https://github.com/langchain4j/llm/tree/${oss-dev-langchain4j}/")")) // {
      languages.coreLLM = self: super: { dev.langchain4j.languages = "1.0.0-beta1"; };
    };

in
{
  nixpkgs.forge.enable = true;
  
  # Define the development environment with 'nix develop'
  nix.devEnv =
    pkgs.mkShell {
      buildInputs = [
        oss-dev-langchain4j.languages.coreLLM
        dev.langchain4j // { languages = "1.0.0-beta1"; }
        com.github.haifengl.smile-scala // { version = "4.3.0" } # This library is part of the project dependencies.
      ];
      
      shellHook = ''
        echo 'Starting nix develop environment'
        export PATH=$(nix-instantiate --eval '(import (pkgs.nixos-hardware.localArch))': { lib.systemPackages = []; stdenvFlags = [ "--override-header" ":extra/copyright: \"\" " ]; } ': default-system)
      '';
    };
}
