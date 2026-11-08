class Mdkg < Formula
  desc "Local-first knowledge graph and coordination kernel for humans and coding agents"
  homepage "https://mdkg.dev"
  version "0.7.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.3/mdkg-aarch64-apple-darwin.tar.gz"
      sha256 "3b63cc7d4a5ae3f728f75575acbc71420f8b79b0cf6b65c0706e7b0eb9e73032"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.3/mdkg-x86_64-apple-darwin.tar.gz"
      sha256 "e86e058234004cfa44e056129a1075fa9465bc5988e31df2091a101d996f2477"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.3/mdkg-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "1de7996f31fb98c5d95201cbd6b4b2e1365a3e82eef1433842bb45a12c9c7609"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.3/mdkg-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "57ab29a7c6931043fbc410eadd9c9a963aba133dc4594827de18c1f831edf0e7"
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
