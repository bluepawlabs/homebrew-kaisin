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
  version "1.1.2291"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-arm64.tar.gz"
      sha256 "63972ad65f0a4d9ca2d79a1432c0782dd6f7bf90db023ba443f16f0ede8467c6"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-x64.tar.gz"
      sha256 "ad8ef29c4df99ae9fd128093e88128512f0acfdbe0e04da6c3f1c4b76a892101"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-arm64.tar.gz"
      sha256 "6439618238f80569f2661f708d2d7460be80cdb4fafd4678222e30173c4d07ce"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-x64.tar.gz"
      sha256 "b75e8bfdb8a0774a6d0ba7b765847a0ea9e8e5b2470d531071ef1bf268d4aaaa"
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
