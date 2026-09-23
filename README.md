# homebrew-kaisin

The Homebrew tap for the [Kaisin](https://kaisin.sh) command line.

```sh
brew install bluepawlabs/kaisin/kaisin
```

Kaisin itself is a self-hosted application platform that installs into your own Kubernetes
cluster — [kaisin.sh/install.html](https://kaisin.sh/install.html) is the walkthrough. This
repository holds only the formula; the binaries it downloads are built and published by the
Kaisin release.

The formula names a version and four digests. They are bumped when a release publishes new
archives, so a tap checked out today installs what the release page hands out.
