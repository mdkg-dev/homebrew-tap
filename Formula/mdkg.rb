class Mdkg < Formula
  desc "Local-first knowledge graph and coordination kernel for humans and coding agents"
  homepage "https://mdkg.dev"
  version "0.7.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.4/mdkg-aarch64-apple-darwin.tar.gz"
      sha256 "3deb78f3e27f8993e37d1d4c3160439978b797ca8e2513c49aceae6d5d7926c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.4/mdkg-x86_64-apple-darwin.tar.gz"
      sha256 "071f4b94d8e075b9b5a812d37c266d6e5ce4d59866b9d41ee5eb3bdd4817a27e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.4/mdkg-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e1d6c6a3106292132d0fd8cfc693a9e74cd753cf43a498fbf4bb92e64fe12656"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.4/mdkg-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d3f5fb87af603911555503738c6e4441c6da20be711d973457fbf392b1b3807e"
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
