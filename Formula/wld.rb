require "json"

class Wld < Formula
  desc "Plan-first AI coding harness"
  homepage "https://github.com/gandazgul/runwield"
  license :cannot_represent

  if Hardware::CPU.arm?
    url "https://github.com/gandazgul/runwield/releases/download/v0.10.1/wld-v0.10.1-darwin-arm64.tar.gz"
    sha256 "0b9b9a1dc10c7d38a95a2b0834d689c996f74a89c2a2975d169ed5985bd21eea"
  else
    url "https://github.com/gandazgul/runwield/releases/download/v0.10.1/wld-v0.10.1-darwin-x64.tar.gz"
    sha256 "7d3cece9e761798bc8f695e593116e10bb0d32013afaa2946a20c7c13dc7b94d"
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
