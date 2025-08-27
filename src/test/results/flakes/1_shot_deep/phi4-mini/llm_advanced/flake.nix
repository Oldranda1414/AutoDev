
{
    outputs = buildInputs (pkgs.fetchFromGit {
      url = "https://github.com/it.unibo/copilot-example-java-junit5-snake-project-idea";
      tag = "main"
      outputHash =
        builtins.currentPlatform.isMac || null
          ? if isLinux then 0 else defaultOutputSource sha256-dceab9aaad7b2e1d6a8f3ef12cbe42ae23ea5eb4af56daedbd54fa17bf45db21 b08dd09de41fb19cc16df36fd31fe01a
          else error "nix: not yet implemented for this platform, please use hash manually"
    },
      inherit inputs;
  }
