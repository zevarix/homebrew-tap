class PantheonLocalTools < Formula
  desc "Provider-neutral local development helpers for Pantheon"
  homepage "https://github.com/zevarix/pantheon-local-tools"
  url "https://github.com/zevarix/pantheon-local-tools/releases/download/v0.2.1/pantheon-local-tools-0.2.1.tar.gz"
  sha256 "ee59a839cc3b5af9a1f305e5ea826ebf08d113936c5569a49dbce52fb996c301"
  license "MIT"

  def install
    libexec.install "bin", "libexec", "VERSION", "LICENSE", "README.md"
    bin.install_symlink libexec/"bin/pantheon-local"
  end

  test do
    assert_match "pantheon-local #{version}", shell_output("#{bin}/pantheon-local --version")

    ENV["PANTHEON_LOCAL_CONFIG"] = testpath/"config"
    system bin/"pantheon-local", "config", "set", "provider", "lando"
    assert_equal "lando", shell_output("#{bin}/pantheon-local config get provider").strip
  end
end
