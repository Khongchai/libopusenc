# Builds .libs/libopusenc.a for wasm.
#
# libopusenc's only external dependency is libopus — the Ogg page writer
# (src/ogg_packer.c) and the speex resampler (src/resample.c) are vendored.
# The configure script normally finds opus via pkg-config (PKG_CHECK_MODULES);
# DEPS_CFLAGS/DEPS_LIBS bypass that and point straight at the sibling
# submodule's build, so run ../opus/wasm-prepare.sh first if
# ../opus/.libs/libopus.a doesn't exist yet.

./autogen.sh

emconfigure ./configure \
  --disable-shared \
  --enable-static \
  --disable-examples \
  --disable-doc \
  DEPS_CFLAGS="-I$(pwd)/../opus/include" \
  DEPS_LIBS="-L$(pwd)/../opus/.libs -lopus" \
  CFLAGS="-O3"

emmake make clean

emmake make

# at this point, libopusenc.a should exist here
# ls -l .libs/libopusenc.a
