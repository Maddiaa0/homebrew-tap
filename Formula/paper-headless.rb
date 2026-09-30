class PaperHeadless < Formula
  desc "Run Paper Desktop on a headless Linux server so its local MCP server is available to agents"
  homepage "https://github.com/Maddiaa0/paper-headless"
  version "0.1.1"
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/Maddiaa0/paper-headless/releases/download/v0.1.1/paper-headless-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2cf3d262ab9bf85633aa659871a871765bd0d54382bfa53cd5b3e93fbbf607cf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/Maddiaa0/paper-headless/releases/download/v0.1.1/paper-headless-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1706f94e12e31b183c9bb4bb4f5c60ba04f1c2628f4e4e323f50e02937bf15bd"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
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
    if OS.linux? && Hardware::CPU.arm?
      bin.install "paper-headless"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "paper-headless"
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
