class Gitalong < Formula
  include Language::Python::Virtualenv
  desc "A command line interface for Git repositories that helps prevent conflicts when working with others."
  homepage "https://github.com/douglaslassance/gitalong-cli"
  url "https://github.com/douglaslassance/gitalong-cli/archive/refs/tags/0.1.0.dev1.tar.gz"
  sha256 "01fc1b0344de6f881bafc93320d8184e46d6de6e87125415c461282b277e78cb"
  license "MIT"
  version "0.1.0.dev1"

depends_on "python@3" => :build

  def install
    virtualenv_create(buildpath/"venv", "python3", system_site_packages: false)
    system "source #{buildpath}/venv/bin/activate && pip install -r #{buildpath}/requirements.txt && pyinstaller --onefile #{buildpath}/cli.py --noconfirm --distpath #{buildpath}/dist --workpath #{buildpath}/build --name gitalong"
    bin.install buildpath/"dist/gitalong"
  end

  test do
    assert_match "gitalong version #{version}", shell_output("#{bin}/gitalong --version")
  end
end
