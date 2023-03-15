# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class GrOsmosdr < Formula
  desc "GNU Radio block for interfacing with various radio hardware"
  homepage "https://osmocom.org/projects/gr-osmosdr/wiki/GrOsmoSDR"
  url "https://github.com/osmocom/gr-osmosdr/archive/refs/tags/v0.2.4.tar.gz"
  sha256 "28b6f2768aee7b397b227e9e70822e28de3b4c5362a5d14646a0948a48094a63"
  license "GPL-3"

  depends_on "cmake" => :build
  depends_on "boost" => :build
  depends_on "gnuradio"
  depends_on "soapysdr"
  depends_on "pybind11"
  depends_on "libsndfile"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    # system "./configure", *std_configure_args, "--disable-silent-rules"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args, "-DENABLE_NONFREE=TRUE"
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test gr-osmosdr`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
