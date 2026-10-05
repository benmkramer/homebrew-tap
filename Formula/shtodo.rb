class Shtodo < Formula
  desc "A blazing fast, fully local TUI based todo app."
  homepage "https://github.com/benmkramer/shtodo"
  version "0.1.0-beta.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.4/shtodo-aarch64-apple-darwin.tar.xz"
      sha256 "a94674e27a0ff9f4fe2e853e8820d0ce6717679f015f73d7d5af292e8482fcfa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.4/shtodo-x86_64-apple-darwin.tar.xz"
      sha256 "5a328b1d9059ed1c195ee23cd29dd3fb579e54b4b2d9e8e999badf3ef2e8133a"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/benmkramer/shtodo/releases/download/v0.1.0-beta.4/shtodo-x86_64-unknown-linux-musl.tar.xz"
    sha256 "9f19659a5f59a19c2a14ac82d0353ab058a8bb9e073aecf5929b1b8a2dfdf3b2"
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
