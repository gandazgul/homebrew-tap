class Mnemoteca < Formula
  desc "Local semantic memory CLI"
  homepage "https://github.com/gandazgul/mnemoteca"
  license "MIT"

  if Hardware::CPU.arm?
    url "https://github.com/gandazgul/mnemoteca/releases/download/v0.3.3/mnemoteca_0.3.3_darwin_arm64.tar.gz"
    sha256 "1096e08c4269962a215fcb534ef54f6b7602d078580adf558a62a59ed49dcb35"
  else
    url "https://github.com/gandazgul/mnemoteca/releases/download/v0.3.3/mnemoteca_0.3.3_darwin_amd64.tar.gz"
    sha256 "db0d5d449c3011dab4566201044951d4270d6b9f3cba94db6bcff49cf27d643e"
  end

  depends_on :macos

  def install
    bin.install "mnemoteca"
  end

  test do
    ENV["MNEMOTECA_DB_PATH"] = testpath/"mnemoteca.sqlite3"
    assert_match "mnemoteca", shell_output(bin/"mnemoteca")
    system bin/"mnemoteca", "init", "--name", "homebrew-test"
  end
end
