# STACK_SIZE: see wasm-compile.sh. STACK_OVERFLOW_CHECK turns silent
# out-of-bounds traps into explicit stack overflow errors while debugging.
emcc -O0 -g opusenc_extension.c .libs/libopusenc.a ../opus/.libs/libopus.a \
  -I include -I ../opus/include \
  -s STACK_SIZE=1048576 -s STACK_OVERFLOW_CHECK=2 \
  -s MODULARIZE=1 -s EXPORT_NAME="createOpusEncModule" \
  -s EXPORTED_FUNCTIONS="['_ope_comments_create', '_ope_comments_add', '_ope_comments_destroy', '_ope_encoder_create_pull', '_ope_encoder_write_float', '_ope_encoder_get_page', '_ope_encoder_drain', '_ope_encoder_destroy', '_ope_strerror', '_variation_ope_encoder_ctl_set_int', '_variation_ope_encoder_ctl_get_int', '_malloc', '_free']" \
  -s EXPORTED_RUNTIME_METHODS=ccall,cwrap,HEAPF32,HEAPU8,HEAP16,HEAP32,UTF8ToString \
  -o opusenc.js
