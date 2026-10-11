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
  version "1.1.551"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-arm64.tar.gz"
      sha256 "39ee0daeeab3c354b971ff1b80b0c6936e3d545307dca2c8e5bcf064bf6812dd"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-x64.tar.gz"
      sha256 "c57d502be45d452b372f5469f120f9e7b23eb186b1efee4856fc72f6a6967e42"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-arm64.tar.gz"
      sha256 "a3c6b4fc29af698653815eb4147105df1dea17e6f59d6ffbc6ef78c37e4a9c47"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-x64.tar.gz"
      sha256 "2ecc160291d9b448a7346997bde958c66d66043387cfddc3292a2015cbd04e75"
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
