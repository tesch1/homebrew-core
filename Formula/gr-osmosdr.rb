class GrOsmosdr < Formula
  desc "GNU Radio block for interfacing with various radio hardware"
  homepage "https://osmocom.org/projects/gr-osmosdr/wiki/GrOsmoSDR"
  url "https://github.com/osmocom/gr-osmosdr/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "28b6f2768aee7b397b227e9e70822e28de3b4c5362a5d14646a0948a48094a63"
  license "GPL-3.0-or-later"

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "airspy"
  depends_on "airspyhf"
  depends_on "gmp"
  depends_on "gnuradio"
  depends_on "hackrf"
  depends_on "librtlsdr"
  depends_on "libsndfile"
  depends_on "pybind11"
  depends_on "python@3.11"
  depends_on "soapysdr"
  depends_on "uhd"
  depends_on "volk"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DENABLE_NONFREE=TRUE"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    system Formula["python@3.11"].opt_bin/"python3.11", "-c", "import osmosdr"
  end
end
