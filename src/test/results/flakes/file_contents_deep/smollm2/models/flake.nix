nix
{
  withBuildSystem := false;

  build:
    nix-build --no-out-link space/models.nix
}
