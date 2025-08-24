nix
{
  pkgs: ["nixpkgs"];

  build: {
    cpp-opts: [["-std=c++17", "-stdlib=libc++"]]
      inline "cpp" cxxFLAGS=-std=gnu++1z, -stdlib=libc++ > src/Makefile

    main.rs: |
      import std;
      use std::io::{BufReader, BufWriter, stdout};

      let file = BufReader::new("../data/flake.txt");
      let mut writer = BuwWriter(stdout());

      for line in file {
        writeln!(writer, "{}", line).unwrap();
      }

    src/Makefile: main.rs
      $(CC) -std=gnu++1z -g -Wall --sysroot=. -m32 -o $@ $<
    }
}


module := "flake";

main := true;

deps := ["nixpkgs"];

include $(shell nix-build '-Sf' "${nixpkgs}/book/nix-build.sh" -A deps)

# The rest of the build rules follow the same pattern as the ones in
# src/book/nix-build.nix, except that they are in the correct format
# for nix crates instead of nix expressions.


[package.config]
build: {
  cpp-opts: [["-std=c++17", "-stdlib=libc++"]]
    inline "cpp" cxxFLAGS=-std=gnu++1z, -stdlib=libc++ > src/Makefile

  main.rs: |
    import std;
    use std::io::{BufReader, BufWriter, stdout};

    let file = BufReader::new("../data/flake.txt");
    let mut writer = BuwWriter(stdout());

    for line in file {
      writeln!(writer, "{}", line).unwrap();
    }

  src/Makefile: main.rs
    $(CC) -std=gnu++1z -g -Wall --sysroot=. -m32 -o $@ $<
}


[package.metadata]
name = "flake";
version = "0.0.0";
homepage = "";


[package.description]
# See https://nix-community.org/docs/getting_started/first_steps.html
description = """
Flake is a simple crate for reading and writing files using the C++17 standard library,
and producing Makefiles with gnu++1z.
""";


# See https://nix-community.org/docs/getting_started/first_steps.html
license = "MIT";


authors = [""];



[package.buildsystems]
cargo-build = ["CROS"];
