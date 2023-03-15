class GrOsmosdr < Formula
  desc "GNU Radio block for interfacing with various radio hardware"
  homepage "https://osmocom.org/projects/gr-osmosdr/wiki/GrOsmoSDR"
  url "https://gitea.osmocom.org/sdr/gr-osmosdr/archive/v0.2.5.tar.gz"
  sha256 "c9c99cae27cbadd0a5eabd5eb28bc5d8179cede12a8ab3b3a594fe932c46c97c"
  license "GPL-3.0-or-later"

  depends_on "boost" => :build
  depends_on "cmake" => :build
  depends_on "pybind11" => :build
  depends_on "airspy"
  depends_on "airspyhf"
  depends_on "gmp"
  depends_on "gnuradio"
  depends_on "hackrf"
  depends_on "librtlsdr"
  depends_on "libsndfile"
  depends_on "python@3.11"
  depends_on "soapysdr"
  depends_on "uhd"
  depends_on "volk"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DENABLE_NONFREE=TRUE", "-DENABLE_DOXYGEN=FALSE"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <osmosdr/device.h>
      int main() {
        osmosdr::device_t device;
        return 0;
      }
    EOS
    system ENV.cxx, "test.cpp", "-L#{lib}", "-lgnuradio-osmosdr", "-o", "test"
    system "./test"

    # Make sure GNU Radio's Python can find our module
    (testpath/"testimport.py").write "import osmosdr\n"
    system Formula["python@3.11"].opt_bin/"python3.11", testpath/"testimport.py"
  end
end
