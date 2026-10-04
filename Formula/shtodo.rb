class Shtodo < Formula
  desc "A blazing fast, fully local TUI based todo app."
  homepage "https://github.com/benmkramer/shtodo"
  version "0.1.0-beta.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.2/shtodo-aarch64-apple-darwin.tar.xz"
      sha256 "62b528713abdb0b514cbbff361a60ac2c2c0f6427cb68b584cdbce8570b889ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.2/shtodo-x86_64-apple-darwin.tar.xz"
      sha256 "16cd572ab15ecaea8c55859fa4bab5701853156869d3a6429ef4b9d33949efaa"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.2/shtodo-x86_64-unknown-linux-musl.tar.xz"
      sha256 "481f9f456b64e9be996384900bf4445ad4a8d6fb2864b0e90d9785cad6788772"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "x86_64-apple-darwin": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "shtodo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "shtodo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "shtodo"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
