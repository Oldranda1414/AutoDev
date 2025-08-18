{ 
  description = "LLM Advanced";
  inputs = {
    unibo-it-llm-advanced = { 
      type = lib.systems.unibo-it-llm-advanced;
      path = ./.;
    };
  };
  outputs = { self, nixpkgs }: let
    pkgs = import nixpkgs {};
    uniboItLlmAdvanced = self.inputs.unibo-it-llm-advanced.packages.x86_64-linux.default;
  in {
    devShell = uniboItLlmAdvanced.devShell(pkgs);
  };
}