flake.nix file:

nix
{
  buildPlugins = {
    "scafi-build-plugin": [],
    "scafi-test-plugin": [
      "-c", "/home/randa/AutoDev/src/test/space/scafi"
    ],
    "*": [
      "--arg-file=basePackages",
      "[{\"name\": \"scifi\"}]"
    ]
  };
}
