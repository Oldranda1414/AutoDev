nix
# flake.nix
buildFlakes = (
    pkgs.gitPatchTree "https://github.com/LLMIntro/llm-intro/tree/main",
    ["flake"]
);
