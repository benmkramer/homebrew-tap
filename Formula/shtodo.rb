class Shtodo < Formula
  desc "A blazing fast, fully local TUI based todo app."
  homepage "https://github.com/benmkramer/shtodo"
  version "0.1.0-beta.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.5/shtodo-aarch64-apple-darwin.tar.xz"
      sha256 "3f0e474c85c70d941e9bd52590fe62dafd2b5aaf983b15754c5c70e0b7c6268a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.5/shtodo-x86_64-apple-darwin.tar.xz"
      sha256 "e409d718b706b7c7d49ed2ed1cf15306a1c80bc1296f76acabad7bbf8437ba2a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.5/shtodo-x86_64-unknown-linux-musl.tar.xz"
    sha256 "3a3d8aa34f4088ad8b82c8f177e4a2e414f03aa65120a6e94dbc54026fe8f64b"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

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
