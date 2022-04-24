#version 300 es

precision highp float;
#ifndef TRY_LEGACY
precision highp uint;
#else
precision highp int;
#endif
precision highp sampler2DArray;

#if !defined(QUANTIZATION) || !defined(N_COMPONENT_BYTES) || !defined(N_COMPONENTS)
#error
#endif

uniform sampler2DArray u_NeuralTexture;
uniform int u_NeuralQuantizationOfZero;
uniform float u_ReciprocalNeuralQuantizationDelta;
#ifdef RENDER_UV
uniform int u_UvQuantizationOfZero;
uniform float u_ReciprocalUvQuantizationDelta;
#endif

in vec2 v_TexCoord;

layout(location = 0) out uvec4 o_PackedNeuralFrag;
#ifdef RENDER_UV
layout(location = 1) out uvec2 o_UvFrag;
#endif

uvec4 getNeuralPixelSlice(int index) {
    return uvec4(ivec4(texture(u_NeuralTexture, vec3(v_TexCoord, index)) * u_ReciprocalNeuralQuantizationDelta) + u_NeuralQuantizationOfZero);
}

// TODO: this shader assumes the neural texture consists of texture slices with RGBA values each
void main() {
    uvec4 packingMultiplier = uvec4(1U, 256U, 65536U, 16777216U);
    uvec4 channelOffsets = uvec4(0U, (N_COMPONENT_BYTES), (N_COMPONENT_BYTES*2U), (N_COMPONENT_BYTES*3U));
    uvec4 rgbaOffsets = channelOffsets % 4U;
    uvec4 sliceOffsets = channelOffsets / 4U;

    uvec4 quantizedSlices[N_SLICES];
    for(int i = 0; i < N_SLICES; ++i) {
        quantizedSlices[i] = getNeuralPixelSlice(i);
    }

    o_PackedNeuralFrag = uvec4(0U);
    for(uint b = 0U; b < N_COMPONENT_BYTES; ++b) {
        uvec4 rgbaBytes = uvec4(
            quantizedSlices[sliceOffsets.r][rgbaOffsets.r],
            quantizedSlices[sliceOffsets.g][rgbaOffsets.g],
            quantizedSlices[sliceOffsets.b][rgbaOffsets.b],
            quantizedSlices[sliceOffsets.a][rgbaOffsets.a]
        );

        o_PackedNeuralFrag += rgbaBytes * packingMultiplier[b];
        rgbaOffsets += uvec4(1U);
    }

#ifdef RENDER_UV
    o_UvFrag = uvec2(ivec2(v_TexCoord*u_ReciprocalUvQuantizationDelta) + u_UvQuantizationOfZero);
#endif

}
