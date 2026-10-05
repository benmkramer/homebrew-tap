class Shtodo < Formula
  desc "A blazing fast, fully local TUI based todo app."
  homepage "https://github.com/benmkramer/shtodo"
  version "0.1.0-beta.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.3/shtodo-aarch64-apple-darwin.tar.xz"
      sha256 "a77c659197896c3c605a43d72f7d05ce2446491e5ba1f0d95a869eaf543113c1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.3/shtodo-x86_64-apple-darwin.tar.xz"
      sha256 "4099e1f182aec79c13725479dce9960a145b8ca325bcc72bffaa2d2b2231df7a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.3/shtodo-x86_64-unknown-linux-musl.tar.xz"
    sha256 "41171d2953615478e0a05c8d237931a3c72b05396fd5982b84ffe59d48eda6d3"
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
