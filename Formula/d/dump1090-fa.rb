class Dump1090Fa < Formula
  desc "Dump1090 is a simple Mode S decoder RTLSDR, HackRF, BladeRF and LimeSDR devices, FlightAware fork"
  homepage "https://github.com/flightaware/dump1090"
  url "https://github.com/flightaware/dump1090/archive/refs/tags/v9.0.tar.gz"
  sha256 "6190622c3625713ec9cff882a9d6f6a51b6d2f83ef20e6e1905a3902c7b08483"
  license "GPL-2.0-or-later"

  depends_on "hackrf"
  depends_on "libbladerf"
  depends_on "librtlsdr"
  depends_on "limesuite"
  depends_on "soapysdr"

  def install
    system "make", "DUMP1090_VERSION=" + version
    bin.install "dump1090" => "dump1090-fa"
    bin.install "view1090" => "view1090-fa"
  end

  test do
    require "base64"
    enc="goB/en99g4B9gH6Eg35/fICVhJl/gXx9f4F+f36Af4B/f3+AgH9+f39/gH+Af4CBf4F/f3
    9/f3+AgIGAgH9/f4F/gX9/gH+Bf4B/f3+Af4F+f359gX5/f36BgYB9fIeGm46Ig3p+mIGYfX19f
    oGFf4B/gIGAf3+AgoR8dHVle3iBhH98fn6AgIB+gIB/gIF/f4F+gYCAf3+AfoB/fX6CgICAen6K
    i5WQhIF6foOBgYB9g454lW6CfH2Cg36AgYCBgX6Af4CAf4B/gICAf39/gICAf39/gICAf35/f4B
    /f35+fn6Af4B/f4B/gIB+f35+gX+BfoF/f39/fYF/fIGDgYF/aHttfISAgIB9gYGBfn6AgIF8fn
    6DlIaXgYF+fn+Df3+AgH+Cf4CAgH+Af4CAf4B+f4CAgH9+f39/foGCgH9xbG1wf4KDgHl/hIGCf
    mSIc4mYfJB9jHSUb4N+e36CgYCCfmp/a3p1cmh3dYGHf39+foCAfX9+gIF9cIddm2ybhIV/e3qZ
    gqyBkYiJjZSHipOJlYp9fIN+pn+ncol3eoGJd5lgjVt+eoCEe2V3aHt5Z2RfY3R8bntjen6BgYB
    hiFmZc46FeXuMd5x/iX+Siq2PmH17hoWUk42GkoGVgpF7k3yOd49wjnSGbIdrhHB8Z3xwfHBsWG
    Vlf4N/gGR4bXlwg2eIdoJpkFyfd417jHWdg4h+eYSal6qNkIyFk42PhZaAkYOOeplyhnl3fpBvm
    FeEYn6Ff3x4ZHlydnNjYmNwfIN/gGN9UYVli4CBfH1mk2OmeZmDfnuFhqaQpIaIjoyWkYF+f32d
    h6t7knV7got4lGmEd4hsi1CAaXx5dGR4dYOGcXFncn2CgoF7gH+Cf4F+f4CAf4GAgYF/gH+AgIB
    /f39/gIF+gH1/f3+Af4CAfoB+f39/gYB/fn5+gIB+fX5+gIJ+e4CCf4F+XYpcjnmGcJBxk4N9fI
    R7qIiphox+fIWLm52kkoh/fIGXgJd7iH2dbKBkhXaHb4tkfn1+gX1fa1VzcoeFdnhlc3R8bXxQh
    mOMg395hmySdo97knuTgI6CkYWTiZKKkJCKkYiPh5iBkn+Pfqhvn2t9gYB9jGaHcIBwfGZ/dHNp
    ZFpzc3N5Y3N3gYOAY39TkGuSgoB8f22ecqp8joKOhp5+hYF8kJOPjZKAlIeQg5d5kX6PeKJnlmy
    Bc4hshW18a4BrfXBwaXVzhIVxdVJvY311gGSGb4WFfHOMbZd7iXiYfa6Dk354hYqNloyKkIiRiJ
    J/k4CRfpVyj3mNdplbj2aAd4Njgm19hnlwdWdxd21zbnRufWw="
    plain = Base64.decode64(enc)
    (testpath/"input.bin").write plain
    result="*5d4d20237a55a6;\n\
CRC: 000000\nRSSI: -14.3 dBFS\n\
Score: 750\nTime: 206.33us\n\
DF:11 AA:4D2023 IID:0 CA:5\n\
 All Call Reply\n\
  ICAO Address:  4D2023 (Mode S / ADS-B)\n\
  Air/Ground:    airborne"
    assert_equal result, shell_output("dump1090-fa --ifile input.bin 2>/dev/null").strip
  end
end
