#include "opusenc.h"

/* ope_encoder_ctl is variadic and can't be called through emscripten's ccall,
 * same situation as opus_encoder_ctl in ../opus/opus_encoder_extension.c.
 * libopusenc forwards OPUS_* encoder requests (e.g. OPUS_SET_BITRATE_REQUEST)
 * to the underlying libopus encoder, so these shims cover both OPE_* and
 * OPUS_* int requests. */

int variation_ope_encoder_ctl_set_int(OggOpusEnc *enc, int request, int value)
{
    return ope_encoder_ctl(enc, request, value);
}

int variation_ope_encoder_ctl_get_int(OggOpusEnc *enc, int request)
{
    opus_int32 value = 0;
    int err = ope_encoder_ctl(enc, request, &value);
    if (err != OPE_OK)
        return err;
    return value;
}
