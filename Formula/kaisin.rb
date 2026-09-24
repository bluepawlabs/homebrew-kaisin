# The command line for Kaisin, a self-hosted application platform on Kubernetes.
#
# This is a tap rather than a formula in homebrew-core, which has a rule against software that
# cannot be built from public source. It lives in its own repository because Homebrew requires
# one: a tap is found by name, and the name is the repository's.
#
# The archives hang off releases on THIS repository, not on bluepawlabs/kaisin. Kaisin is private
# and Homebrew fetches with no credentials, so a url pointing there answers 404 for everybody
# outside the organisation — which is to say, for everybody `brew install` is for.
#
#   brew install bluepawlabs/kaisin/kaisin
#
# The version and the four digests are written by the release that published the archives. Bumping
# them by hand is how a formula ends up pointing at a version nobody is running.
class Kaisin < Formula
  desc "Self-hosted application platform built on Kubernetes"
  homepage "https://kaisin.sh"
  version "1.1.183"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-arm64.tar.gz"
      sha256 "cbc6d3d01593b964291db48d3152e052755a9bcbdb8c1f294ea0c6cddd7e7a6d"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-osx-x64.tar.gz"
      sha256 "9e61745c5d83bc7039727e4049ecf025e37f3596599225b19ea73d7743ecf00d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-arm64.tar.gz"
      sha256 "fb35873acd3c28fd2c778fc07b994b28cb94a45e83e5ee2d4d3534453b3243a8"
    else
      url "https://github.com/bluepawlabs/homebrew-kaisin/releases/download/v#{version}/kaisin-#{version}-linux-x64.tar.gz"
      sha256 "647ee47641fc838b0db23d9ec64ed5a100bc83cebbb9ef39762def20f53fe417"
    end
  end

  def install
    bin.install "kaisin"
  end

  # The archive holds one already-linked binary, so there is nothing to check about the build. What
  # is worth checking is that the thing installed runs at all and is the version the formula
  # claims — which catches a digest bumped without its version, and a trimmed publish that lost
  # something it needed and dies on first execution.
  test do
    assert_match version.to_s, shell_output("#{bin}/kaisin --version")
  end
end
