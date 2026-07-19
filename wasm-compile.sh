# STACK_SIZE: emscripten's default shadow stack is 64KB. libopus uses C
# variable-length arrays on the stack, and going through libopusenc adds the
# multistream encoder layer on top — 64KB overflows inside celt_encode_with_ec
# ("memory access out of bounds"). 1MB gives comfortable headroom.
emcc -O3 opusenc_extension.c .libs/libopusenc.a ../opus/.libs/libopus.a \
  -I include -I ../opus/include \
  -s STACK_SIZE=1048576 \
  -s MODULARIZE=1 -s EXPORT_NAME="createOpusEncModule" \
  -s EXPORTED_FUNCTIONS="['_ope_comments_create', '_ope_comments_add', '_ope_comments_destroy', '_ope_encoder_create_pull', '_ope_encoder_write_float', '_ope_encoder_get_page', '_ope_encoder_drain', '_ope_encoder_destroy', '_ope_strerror', '_variation_ope_encoder_ctl_set_int', '_variation_ope_encoder_ctl_get_int', '_malloc', '_free']" \
  -s EXPORTED_RUNTIME_METHODS=ccall,cwrap,HEAPF32,HEAPU8,HEAP16,HEAP32,UTF8ToString \
  -o opusenc.js
