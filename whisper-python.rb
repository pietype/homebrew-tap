class WhisperPython < Formula
  desc "Whisper interpreter written in Python 2.7"
  homepage "https://github.com/pietype/whisper-python"
  url "https://github.com/pietype/whisper-python/archive/0.1.3.tar.gz"
  version "0.1.3"
  sha256 "20ffe3abe450c0a8bfcb3d000cad72d48f897a6f4da5b8256a3ba82ac5f63a71"

  resource "ply" do
    url "https://pypi.python.org/packages/96/e0/430fcdb6b3ef1ae534d231397bee7e9304be14a47a267e82ebcb3323d0b5/ply-3.8.tar.gz"
    sha256 "e7d1bdff026beb159c9942f7a17e102c375638d9478a7ecd4cc0c76afd8de0b8"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[ply].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install "whisper"
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end
end
