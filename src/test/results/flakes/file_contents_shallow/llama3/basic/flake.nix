{ description = "Basic Development Environment";
  inputs = {
    julia = builtins.fetchTarball https://github.com/julia-jll/julia/tarball/master;
  };
  outputs = { self: {
    defaultApp = javaBuildInputs [ self.julia ];
    shell = pkgs.mkShell({
      commands = [
        "${self.julia}/bin/julia -e 'println(\"Hello, world!\")'"
      ];
    });
  }};
buildInputs = [ jll2.julia ];
shell = inputs.project.activatedShell;
name = "basic";
builder = ./builder.sh;

outputs = { self: rec {
  shell = pkgs.mkShell({
    commands = [
      "${self.julia}/bin/julia basic/hello.jl"
    ];
  });
};