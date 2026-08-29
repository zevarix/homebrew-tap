class PantheonLocalTools < Formula
  desc "Provider-neutral local development helpers for Pantheon"
  homepage "https://github.com/zevarix/pantheon-local-tools"
  url "https://github.com/zevarix/pantheon-local-tools/releases/download/v0.1.1/pantheon-local-tools-0.1.1.tar.gz"
  sha256 "a85e14adedb98895c893f02f400dd5168c760cfc05f450c69c438ca95c047f19"
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
