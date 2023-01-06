{ fetchFromGitHub, buildGoModule }:

buildGoModule rec {
  pname = "plik";
  version = "master";

  src = fetchFromGitHub {
    owner = "root-gg";
    repo = "plik";
    rev = "4ba41a50d0946b5d9b359c2624aa7ac47f908c25";
    sha256 = "014krrc6203maycz578m1zf55gqsm6aj6skgh0fa0kw2blf8m94y";
  };

  vendorSha256 = "1j6bjc3x4i6i0hqmqich3i1cfxagx6vmzy00pj4la719xvj3xxkw";

  subPackages = [ "." ];
}
