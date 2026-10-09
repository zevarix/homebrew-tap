class PantheonLocalTools < Formula
  desc "Provider-neutral local development helpers for Pantheon"
  homepage "https://github.com/zevarix/pantheon-local-tools"
  url "https://github.com/zevarix/pantheon-local-tools/releases/download/v0.2.3/pantheon-local-tools-0.2.3.tar.gz"
  sha256 "659a13104b1756e36dcdca6edec01863d70a58c77f3a0f8d20365fcddff083ef"
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
