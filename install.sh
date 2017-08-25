#!/bin/sh

ncmake_dirname="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ncmake_download_url="https://cmake.org/files/v3.9/cmake-3.9.1.tar.gz"
ncmake_nproc=$(nproc 2>/dev/null || sysctl -n hw.ncpu)

die() {
  echo "$@" 1>&2 ; exit 1
}

ncmake_compile_cmake() {
  cd cmake-3.9.1 \
    && ./bootstrap \
        --prefix=${1} \
        --docdir="" \
        --parallel=${2} \
        --system-zlib \
        --no-qt-gui \
        --system-bzip2 \
        --system-curl \
        --no-system-libs \
        --no-server \
        --sphinx-build=0 \
    && make \
    && make install -j${2}
}

ncmake_download() {
  wget ${1} -O - | tar -xz
}

ncmake_install_cmake() {
  if [ ! -d "cmake-3.9.1" ]; then
      ncmake_download ${ncmake_download_url}
  fi
  ncmake_install_cmake ${ncmake_dirname} ${ncmake_nproc}
  rm -rf cmake-3.9.1
}

if [ ! -z $(which cmake) ]; then
  echo "--- CMake detected version: $(cmake --version| head -1| awk '{print $3}')"
  if [ ! -f ${ncmake_dirname}/bin/cmake ]; then
      ln -s $(which cmake) ${ncmake_dirname}/bin/cmake
  fi
else
  echo "--- Installing CMake"
  ncmake_install_cmake
fi

${ncmake_dirname}/bin/ncmake test
