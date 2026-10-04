cask "screenshotmaxxing" do
  version "2.0.9,14"
  sha256 "8bccfe0eff83d38bd6d4d071ddbb9db734fc392ab64781ec184b2ef09517d379"

  url "https://github.com/benmkramer/ScreenshotMaxxing/releases/download/v#{version.csv.first}/ScreenshotMaxxing-#{version.csv.first}.dmg"
  name "ScreenshotMaxxing"
  desc "Menu bar screenshot and screen recording utility"
  homepage "https://github.com/benmkramer/ScreenshotMaxxing"

  livecheck do
    skip "Updated by the ScreenshotMaxxing release workflow with bundle build numbers"
  end

  depends_on arch: [:arm64, :x86_64]
  depends_on macos: :tahoe

  app "ScreenshotMaxxing.app"

  caveats do
    "Requires macOS 26.2 or later. Captures and preferences are preserved on uninstall."
  end
end
