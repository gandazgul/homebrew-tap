require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/gandazgul/runwield"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/gandazgul/runwield/releases/download/v0.11.3/wld-v0.11.3-darwin-arm64.tar.gz"
    sha256 "4c2daee93f5a4980b5e61580e8013eb65d1837bf0f6e46fb6bb08667df116716"
  else
    url "https://github.com/gandazgul/runwield/releases/download/v0.11.3/wld-v0.11.3-darwin-x64.tar.gz"
    sha256 "4ab6ad6ecd73dbf0bacad7fdd8e56beaa3af604fb0c749f4736ba237d3cad3ff"
  end

  depends_on "1broseidon/tap/cymbal"
  depends_on "agent-browser"
  depends_on "gandazgul/tap/mnemoteca"
  depends_on "git"
  depends_on "ketch"
  depends_on :macos

  def install
    libexec.install "wld"
    (libexec/"runwield-install.json").write JSON.pretty_generate({
      schemaVersion:     1,
      packageManager:    "homebrew",
      packageIdentifier: "gandazgul/tap/wld",
      updateCommand:     "brew upgrade gandazgul/tap/wld",
      repairCommand:     "brew reinstall gandazgul/tap/wld",
      installDirectory:  libexec.to_s,
      version:           "v#{version}",
    })
    bin.install_symlink libexec/"wld" => "wld"
  end

  test do
    assert_match "runwield", shell_output("#{bin}/wld --version")
    assert_match "brew upgrade gandazgul/tap/wld", shell_output("#{bin}/wld update")
  end
end
