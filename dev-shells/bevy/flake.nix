{
  description = "A Nix-flake-based Bevy development environment";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1.*.tar.gz";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems ( system: f {
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ rust-overlay.overlays.default self.overlays.default ];
        };
      });
    in
      {
      overlays.default = final: prev: {
        rustToolchain = final.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      };

      devShells = forEachSupportedSystem ( { pkgs }:
          {
          default = pkgs.mkShell rec {
            packages = with pkgs; [
              rustToolchain
              openssl
              pkg-config
              cargo-deny
              cargo-edit
              cargo-watch
              rust-analyzer
              clang
              mold
            ];

            env = {
              # Required by rust-analyzer
              RUST_SRC_PATH = "${pkgs.rustToolchain}/lib/rustlib/src/rust/library";
            };

            # Bevy stuff
            nativeBuildInputs = with pkgs; [
              pkg-config
            ];
            buildInputs = with pkgs; [
              udev alsa-lib-with-plugins vulkan-loader
              xorg.libX11 xorg.libXcursor xorg.libXi xorg.libXrandr # To use the x11 feature
              libxkbcommon wayland # To use the wayland feature
            ];
            LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath buildInputs;

            shellHook = ''
              export CC=clang
              export CXX=clang++
              export RUSTFLAGS="-Clinker=clang -Clink-arg=-fuse-ld=mold"
            '';
          };
        }
      );
    };
}
