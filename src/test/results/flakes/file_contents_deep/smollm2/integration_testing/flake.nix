nix
  %%
    export TEST_DIR=$HOME/AutoDev/src/test/space/integration_testing
%
    {
        buildInputs: [
          #{"name": "nixpkgs", "version": "3.10"};
        ]
      };

    sourcePackages = with nixpkgs; import space-integration-testing;

    include./build-space-integration-test.sh;
