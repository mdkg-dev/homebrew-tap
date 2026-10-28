class Mdkg < Formula
  desc "Local-first knowledge graph and coordination kernel for humans and coding agents"
  homepage "https://mdkg.dev"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.0/mdkg-aarch64-apple-darwin.tar.gz"
      sha256 "0644aa74a72432ae544f1ffd44470dffcc4b8030faa574c702351f8cf8c9a506"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.0/mdkg-x86_64-apple-darwin.tar.gz"
      sha256 "d578d892b65840fa181ba9f0722fc0243782bbdc08fde43a07290af3b0c1cb1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.0/mdkg-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e0507e1aa8261085e1e29e4395e32d91331b4c218ad7348e174e769ba07091e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mdkg-dev/mdkg/releases/download/v0.7.0/mdkg-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2ab6e35e5502d4c7778b5d21182692c63897165742632eec027aedd134e15524"
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
