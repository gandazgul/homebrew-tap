require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/gandazgul/runwield"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/gandazgul/runwield/releases/download/v0.10.2/wld-v0.10.2-darwin-arm64.tar.gz"
    sha256 "172d8874ad7d0091787aa0e20f1103bb2b5f33da9cf3f8ee54dc47feae23cb58"
  else
    url "https://github.com/gandazgul/runwield/releases/download/v0.10.2/wld-v0.10.2-darwin-x64.tar.gz"
    sha256 "7fe80b3e795954e2b5cd49c228b98e7195461e4f350ef3e7ae2b18584123efdb"
  end

  depends_on "1broseidon/tap/cymbal"
  depends_on "1broseidon/tap/ketch"
  depends_on "agent-browser"
  depends_on "gandazgul/tap/mnemoteca"
  depends_on "git"
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
