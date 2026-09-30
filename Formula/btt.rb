class Btt < Formula
  desc "Branch tree testing for any language: check and scaffold test suites from bulloak-style .tree specs"
  homepage "https://github.com/Maddiaa0/btt"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/Maddiaa0/btt/releases/download/v0.2.0/btt-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c8c0564ea25ea84230deb87b4e6a39030707846db83cde5625efa9e973c7c6b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Maddiaa0/btt/releases/download/v0.2.0/btt-cli-x86_64-apple-darwin.tar.xz"
      sha256 "602ea00a5e7cadced089f5a40821bda26d560257383078489c5c76ebb6974a6f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Maddiaa0/btt/releases/download/v0.2.0/btt-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f8f44527be0677a3cef2fd557dc5b65602657ea94841fc24d8d485643baae7c3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Maddiaa0/btt/releases/download/v0.2.0/btt-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2b80ad4cf92390e21de1546b95e86c8acfd04a5375d37f86c23001ac68c09b48"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

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
      bin.install "btt"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "btt"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "btt"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "btt"
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
