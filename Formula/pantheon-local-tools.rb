class PantheonLocalTools < Formula
  desc "Provider-neutral local development helpers for Pantheon"
  homepage "https://github.com/zevarix/pantheon-local-tools"
  url "https://github.com/zevarix/pantheon-local-tools/releases/download/v0.2.4/pantheon-local-tools-0.2.4.tar.gz"
  sha256 "72279bedff2346fbb22a0f44b3dfa492b1428bcb2228ff8b1f0273526a767c32"
  license "MIT"

  def install
    libexec.install "bin", "libexec", "shell", "VERSION", "LICENSE", "README.md"
    bin.install_symlink libexec/"bin/pantheon-local"
    bin.install_symlink libexec/"bin/pantheon-local" => "plt"
  end

  test do
    assert_match "pantheon-local #{version}", shell_output("#{bin}/pantheon-local --version")
    assert_match "pantheon-local #{version}", shell_output("#{bin}/plt --version")

    ENV["PANTHEON_LOCAL_CONFIG"] = testpath/"config"
    system bin/"pantheon-local", "config", "set", "provider", "lando"
    assert_equal "lando", shell_output("#{bin}/pantheon-local config get provider").strip
  end
end
