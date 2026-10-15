{
  description = "rextract - shell regex capture extractor";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAll = f: nixpkgs.lib.genAttrs systems (s: f nixpkgs.legacyPackages.${s});
    in {
      packages = forAll (pkgs: rec {
        rextract = pkgs.buildGoModule {
          pname = "rextract";
          version = self.shortRev or self.dirtyShortRev or "dev";
          src = ./.;
          vendorHash = null;
          ldflags = [ "-s" "-w" ];
          meta.mainProgram = "rextract";
        };
        default = rextract;
      });

      devShells = forAll (pkgs: {
        default = pkgs.mkShell { packages = [ pkgs.go pkgs.just pkgs.goreleaser ]; };
      });
    };
}
