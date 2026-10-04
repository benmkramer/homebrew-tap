# Homebrew Tap

Homebrew packages maintained by Ben Kramer.

## Install shtodo

```sh
brew install benmkramer/tap/shtodo
```

The formula installs prebuilt binaries from
[benmkramer/shtodo releases](https://github.com/benmkramer/shtodo/releases)
and verifies their SHA-256 checksums. It supports Apple Silicon macOS,
Intel macOS, and x86-64 Linux.

The shtodo formula currently distributes beta releases. Its release workflow
updates the formula after new releases are published.

## Update

```sh
brew update
brew upgrade shtodo
```

## Install ScreenshotMaxxing

After the cask is merged into this tap:

```sh
brew install --cask benmkramer/tap/screenshotmaxxing
open -a ScreenshotMaxxing
```

ScreenshotMaxxing is a native menu bar screenshot and screen recording app.
It requires **macOS 26.2 or later** and supports Apple Silicon and Intel with
the same universal app. The cask installs `ScreenshotMaxxing.app` from the
official [public GitHub release DMG](https://github.com/benmkramer/ScreenshotMaxxing/releases).
Homebrew verifies the pinned SHA-256; the original Developer ID signature,
notarization, quarantine, and macOS permissions remain in effect.

Quit the app before upgrading or uninstalling:

```sh
brew update
brew upgrade --cask benmkramer/tap/screenshotmaxxing
brew uninstall --cask benmkramer/tap/screenshotmaxxing
```

Upgrades and normal uninstall preserve local captures, SwiftData history,
and preferences. The cask has no `zap` stanza. If the app was installed
manually, quit it and move only `/Applications/ScreenshotMaxxing.app` out of
Applications before using Homebrew. Keep
`~/Library/Application Support/ScreenshotMaxxing/` and your preferences.
Homebrew refuses to overwrite an existing app by default.

## Maintaining ScreenshotMaxxing

`Casks/screenshotmaxxing.rb` follows stable numeric releases only. Drafts and
prereleases are excluded. The cask version includes the bundle build number
as `<marketing-version>,<build>` so build-only releases are upgradable. Its
macOS dependency uses Homebrew's major-release symbol `:tahoe`; the caveat
and app bundle state and enforce the exact 26.2 minimum.

The app repository owns the automation. After its final release asset is
published, it downloads the public DMG without authentication, checks its
SHA-256 against published metadata, verifies bundle requirements, Developer ID
signing, notarization, and Gatekeeper acceptance, then runs Homebrew style and
strict online audits. It commits only this app's cask to tap `main`, with
serialized writes, idempotency, and downgrade protection. The initial seed is
v2.0.9 (build 14); future updates become active when the app automation PR merges.

Maintainers should configure `HOMEBREW_TAP_TOKEN` in the **ScreenshotMaxxing**
repository's Actions secrets. Prefer a fine-grained GitHub token restricted to
**benmkramer/homebrew-tap** with **Contents: Read and write**, plus GitHub's
mandatory metadata read access. No Pull requests or Workflows permission is
needed. The token owner must be allowed to push to tap `main`. Inspect existing
secret names and add a missing token through GitHub or the interactive CLI:

```sh
gh secret list --repo benmkramer/ScreenshotMaxxing
gh secret set HOMEBREW_TAP_TOKEN --repo benmkramer/ScreenshotMaxxing
```

Never paste credentials into chat, source, logs, or command arguments. Secret
presence does not confirm its scope, expiration, or validity. Existing Apple
signing/notarization credentials remain in the app repository.

Merge the cask PR before the app automation PR. Retry a failed tap sync on app
`main` without rebuilding or republishing the release:

```sh
gh workflow run update-homebrew.yml --repo benmkramer/ScreenshotMaxxing --ref main -f tag=v2.0.9
```

To review a manual cask change from this checkout:

```sh
ruby -c Casks/screenshotmaxxing.rb
brew style "$PWD/Casks/screenshotmaxxing.rb"
brew audit --cask --strict --online "$PWD/Casks/screenshotmaxxing.rb"
```

Keep changes confined to this cask and its documentation. Use a disposable
macOS user or CI runner for launch/upgrade tests, and an isolated `--appdir`
for installation tests. Do not use `--force`, `--adopt`, `--zap`, reset TCC,
or overwrite an existing installation while testing.

See the app's [release guide](https://github.com/benmkramer/ScreenshotMaxxing/blob/main/docs/RELEASING.md#homebrew-distribution)
for full verification and retry details. The cask follows the official
[Cask Cookbook](https://docs.brew.sh/Cask-Cookbook),
[tap guide](https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap), and
[brew manual](https://docs.brew.sh/Manpage).
