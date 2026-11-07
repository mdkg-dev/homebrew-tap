class Mdkg < Formula
  desc "Local-first knowledge graph and coordination kernel for humans and coding agents"
  homepage "https://mdkg.dev"
  version "0.7.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.2/mdkg-aarch64-apple-darwin.tar.gz"
      sha256 "8adc9c57b869b7d2c0d2c45d2d3e7de1071343acc3dc9a1f0e8ac9bc358576c8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.2/mdkg-x86_64-apple-darwin.tar.gz"
      sha256 "f0714d55904618d9bbb00b2a1a87b3533ac239c335950b5c9de9ab84f97cd6a9"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.2/mdkg-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "9e50247eb784b11316a7a84cc08910a461f2e27077e81557fecd0fb2ed665969"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.2/mdkg-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5dc745c0eb27f76b64a98598c53690ecb8ef5a0e46123f9c878e7e87a17c14d4"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
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
      bin.install "mdkg"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mdkg"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "mdkg"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mdkg"
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
