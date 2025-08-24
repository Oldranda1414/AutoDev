 
{ stdenv, git }

describe "integration_testing" {
  homepage = "https://github.com/your-username/integration_testing";
  src = gitAttrs {
    url = "https://github.com/your-username/integration_testing.git";
  }
}
