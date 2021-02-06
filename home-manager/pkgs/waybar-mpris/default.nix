{ fetchgit, buildGoModule }:

buildGoModule rec {
  pname = "waybar-mpris";
  version = "master";

  src = fetchgit {
    url = "https://git.hrfee.pw/hrfee/waybar-mpris";
    rev = "b97a950582";
    sha256 = "1w6zjgkixhmligf7jlf1rzw3zw1wmz806g65894rd3kda6g56ak1";
  };

  vendorSha256 = "13b4izfjlk85h29gv20kx6nwq05vg8dblp35bggckq0yln8vqvm7";

  subPackages = [ "." ];
}
