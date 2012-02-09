require 'formula'

class Teem < Formula
  url 'https://sourceforge.net/projects/teem/files/teem/1.10.0/teem-1.10.0-src.tar.gz'
  homepage 'http://teem.sourceforge.net/'
  md5 'efe219575adc89f6470994154d86c05b'
  head 'https://teem.svn.sourceforge.net/svnroot/teem/teem/trunk'

  depends_on 'cmake' => :build

  def options
    [
      ['--experimental-apps', "Build experimental apps"],
      ['--experimental-libs', "Build experimental libs"],
      ['--hex', "Build dehex and enhex"],
      ['--enable-shared', "Build shared libraries"],
      ['--enable-testing', "Perform testing of Teem"],
    ]
  end

  def install
    cmake_args = std_cmake_parameters.split

    if ARGV.include? '--experimental-apps'
      cmake_args << "-DBUILD_EXPERIMENTAL_APPS:BOOL=ON"
    end
    if ARGV.include? '--experimental-libs'
      cmake_args << "-DBUILD_EXPERIMENTAL_LIBS:BOOL=ON"
    end
    if ARGV.include? '--hex'
      cmake_args << "-DBUILD_HEX:BOOL=ON"
    end
    if ARGV.include? '--enable-shared'
      cmake_args << "-DBUILD_SHARED_LIBS:BOOL=ON"
    end
    if ARGV.include? '--enable-testing'
      cmake_args << "-DBUILD_TESTING:BOOL=ON"
    end

    cmake_args << "."

    system "cmake", *cmake_args
    system "make install"
  end

  def test
    system "unu about"
  end

  def patches
    # fixes issues with linking to more recent libpng bundled with OS X
    # (fixed in head)
    "https://raw.github.com/gist/1781600/teem-libpng.patch"
  end
end
