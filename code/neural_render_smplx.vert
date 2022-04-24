#version 300 es

#define N_SMPLX_JOINTS 55

precision highp float;

uniform mat4 u_ModelViewProjection;
uniform mat4 u_JointsTransforms[N_SMPLX_JOINTS];

layout(location = 0) in vec4 a_TemplatePosition;
layout(location = 1) in vec2 a_TexCoord;

// FIXME: for some reason compiler disallows arrays in Vertex Shader's attribute definition
// But OpenGLES 3.0 should permit it...
layout(location = 2) in vec4 a_BiggestJointWeights_0;
layout(location = 3) in ivec4 a_BiggestJointWeightsIdx_0;
layout(location = 4) in vec4 a_BiggestJointWeights_1;
layout(location = 5) in ivec4 a_BiggestJointWeightsIdx_1;
layout(location = 6) in vec4 a_BiggestJointWeights_2;
layout(location = 7) in ivec4 a_BiggestJointWeightsIdx_2;

out vec2 v_TexCoord;

void main() {

    // NOTE: to squeeze the maximum performance you can comment out some last lines
    // They correspond to the smallest weights.
    // 4 first lines still give acceptable quality of SMPLX
    // 10 first lines is the maximum number of non-zero weights for all mesh vertices
    // 12 lines are here is just to be safe
    mat4 uniqueVertexTransform =
    (
        (u_JointsTransforms[a_BiggestJointWeightsIdx_0.x] * a_BiggestJointWeights_0.x +
         u_JointsTransforms[a_BiggestJointWeightsIdx_0.y] * a_BiggestJointWeights_0.y)
        + 
		(u_JointsTransforms[a_BiggestJointWeightsIdx_0.z] * a_BiggestJointWeights_0.z + 
         u_JointsTransforms[a_BiggestJointWeightsIdx_0.w] * a_BiggestJointWeights_0.w
          )
    )
        +
    (
          (
          u_JointsTransforms[a_BiggestJointWeightsIdx_1.x] * a_BiggestJointWeights_1.x
        + u_JointsTransforms[a_BiggestJointWeightsIdx_1.y] * a_BiggestJointWeights_1.y
          )
        + (
          u_JointsTransforms[a_BiggestJointWeightsIdx_1.z] * a_BiggestJointWeights_1.z
        + u_JointsTransforms[a_BiggestJointWeightsIdx_1.w] * a_BiggestJointWeights_1.w
          )
    )
        +
    (
          (
          u_JointsTransforms[a_BiggestJointWeightsIdx_2.x] * a_BiggestJointWeights_2.x
        + u_JointsTransforms[a_BiggestJointWeightsIdx_2.y] * a_BiggestJointWeights_2.y
          )
//        + (
//          u_JointsTransforms[a_BiggestJointWeightsIdx_2.z] * a_BiggestJointWeights_2.z
//        + u_JointsTransforms[a_BiggestJointWeightsIdx_2.w] * a_BiggestJointWeights_2.w
//          )
    );
    uniqueVertexTransform[3][3] = 1.0;
    gl_Position = u_ModelViewProjection * (uniqueVertexTransform * a_TemplatePosition);
    v_TexCoord = a_TexCoord;
}
