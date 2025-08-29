{ 
  description = "LLM Intro";
  inputs = {
    self = {};
    build = builtins.fetchGit {
      url = "file:///home/randa/AutoDev/src/test/space/llm_intro";
      rev = "HEAD";
    };
  };

  outputs = { self: rec {

    devShell = self.buildEnv {
      name = "dev-shell";
      paths = [
        self.build.inputs.build.outputTarget("assembly")
        ./src/main/java
        ./src/main/resources
      ];
    };
  };