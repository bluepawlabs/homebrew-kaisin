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
  version "1.1.547"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-arm64.tar.gz"
      sha256 "c5706b865fe1dbe5f3b048ead4e7eb93e3d1a1194c45e98322432ca8117dbd4d"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-x64.tar.gz"
      sha256 "4db8a4f26c78b705490899aa2051ecb36845f64ffc99a430021789224dbf3ea4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-arm64.tar.gz"
      sha256 "c6bc9d4f0ab601d11914401fc623ae3aa57b6547803677bbeb20cb43f9c16b5c"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-x64.tar.gz"
      sha256 "f3fc35882f56c17d40c0d3ddb32d442e8232d10d065fd9eb3cea77531b69405c"
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
