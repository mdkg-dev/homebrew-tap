class Mdkg < Formula
  desc "Local-first knowledge graph and coordination kernel for humans and coding agents"
  homepage "https://mdkg.dev"
  version "0.7.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.1/mdkg-aarch64-apple-darwin.tar.gz"
      sha256 "0efbfc00b0db1046a0acaad0c3830daddfc8c4da062d75b5dd078ad0555d3dbd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.1/mdkg-x86_64-apple-darwin.tar.gz"
      sha256 "b5ba49f760dc7eff7115cf0c0da44c0bc297b00955557bc706893bab4562efa4"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.1/mdkg-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4e098d6125c2e241ded2cf88b22976902f257844fb84d49982c9e75b13d9c983"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.1/mdkg-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ddcaa443057097cd20bd98d193f21e368d68997fdfab2eb1c1d7725174bf3bea"
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
