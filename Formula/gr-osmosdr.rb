class GrOsmosdr < Formula
  desc "GNU Radio block for interfacing with various radio hardware"
  homepage "https://osmocom.org/projects/gr-osmosdr/wiki/GrOsmoSDR"
  url "https://github.com/osmocom/gr-osmosdr/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "28b6f2768aee7b397b227e9e70822e28de3b4c5362a5d14646a0948a48094a63"
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

  # PR: https://github.com/osmocom/gr-osmosdr/pull/25 - removes use of ancient 'register' keyword
  patch :DATA

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

__END__
diff --git a/lib/hackrf/hackrf_sink_c.cc b/lib/hackrf/hackrf_sink_c.cc
index 1762934..54ff3ef 100644
--- a/lib/hackrf/hackrf_sink_c.cc
+++ b/lib/hackrf/hackrf_sink_c.cc
@@ -299,7 +299,7 @@ void convert_avx(const float* inbuf, int8_t* outbuf,const unsigned int count)
 #elif USE_SSE2
 void convert_sse2(const float* inbuf, int8_t* outbuf,const unsigned int count)
 {
-  const register __m128 mulme = _mm_set_ps( 127.0f, 127.0f, 127.0f, 127.0f );
+  const __m128 mulme = _mm_set_ps( 127.0f, 127.0f, 127.0f, 127.0f );
   __m128 itmp1,itmp2,itmp3,itmp4;
   __m128i otmp1,otmp2,otmp3,otmp4;
 
