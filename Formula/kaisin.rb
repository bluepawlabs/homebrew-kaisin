# The command line for Kaisin, a self-hosted application platform on Kubernetes.
#
# This is a tap rather than a formula in homebrew-core, which has a rule against software
# that cannot be built from public source. It lives in its own repository because Homebrew
# requires one: a tap is found by name, and the name is the repository's.
#
# The archives hang off releases on THIS repository, not on bluepawlabs/kaisin. Kaisin is
# private and Homebrew fetches with no credentials, so a url pointing there answers 404
# for everybody outside the organisation — which is to say, for everybody `brew install`
# is for.
#
#   brew install bluepawlabs/kaisin/kaisin
#
# Generated in full by the release that published the archives. Editing it by hand is how
# a formula ends up pointing at a version nobody is running.
class Kaisin < Formula
  desc "Self-hosted application platform built on Kubernetes"
  homepage "https://kaisin.sh"
  version "1.1.306"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-arm64.tar.gz"
      sha256 "beec2cc9cce7e83e856d5fa1eeba98b36da28e89e6fcf50a702db61536694bcd"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-x64.tar.gz"
      sha256 "c8f74d94adaa2724da258ccdd2a63afdadc70f724258218f5fb3cc8613438eee"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-arm64.tar.gz"
      sha256 "cdc083474f1de1bb09e10228dc5d9cd6e12c2c7fcb89b0b91c85ecdfc62fdfdb"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-x64.tar.gz"
      sha256 "aa7555f01713cf3db4f15c9776bb0aedc1143b0d2ed60ffa1bca914cc64d5b66"
    end
  end

  def install
    bin.install "kaisin"
  end

  # The archive holds one already-linked binary, so there is nothing to check about the
  # build. What is worth checking is that the thing installed runs at all and is the
  # version the formula claims — which catches a digest bumped without its version, and a
  # trimmed publish that lost something it needed and dies on first execution.
  test do
    assert_match version.to_s, shell_output("#{bin}/kaisin --version")
  end
end
