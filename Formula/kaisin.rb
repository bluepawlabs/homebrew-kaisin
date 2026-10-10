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
  version "1.1.448"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-arm64.tar.gz"
      sha256 "b10d389bbfef58ea9bf727c0857e85de1f44c1c4d87af417aa200a57c12957ef"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-x64.tar.gz"
      sha256 "d395cfee8c0f89e0fee22808f74780e3cd0ec9c866eaa9cba4cf5eef08568051"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-arm64.tar.gz"
      sha256 "a4a1eeb8412bb40269985b7f66dd094e9c55e5313ae8f324e116dbfca0781888"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-x64.tar.gz"
      sha256 "110ac0c98dbfae01380c10505d0ca45221531eb4bd2f06c406d00392eefb0ccd"
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
