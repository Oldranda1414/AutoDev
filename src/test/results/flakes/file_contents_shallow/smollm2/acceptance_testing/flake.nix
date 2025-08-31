nix
withBuildDependencies:
  flake {
    name: "acceptance_testing";
    path: "./acceptance_testing";
    imports:
      - scala-3.11.8/src/library;
      - task-temp-directory;
      - stream-utils-3.11.8/src/main/scala;
    features: ["./src/main/resources"]
  }
