

{
  outputs = { self, ... }: {
    devShells."x86_64-linux".default = {
      nativeBuildInputs = [ ];
      buildInputs = [ ];
      # Add any packages or dependencies needed for the shell
    };
  };
}