class PantheonLocalTools < Formula
  desc "Provider-neutral local development helpers for Pantheon"
  homepage "https://github.com/zevarix/pantheon-local-tools"
  url "https://github.com/zevarix/pantheon-local-tools/releases/download/v0.2.5/pantheon-local-tools-0.2.5.tar.gz"
  sha256 "394db728d1d73f67a5ea25bd970f2749ee08217ab431de12ab5297675966c6bd"
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
