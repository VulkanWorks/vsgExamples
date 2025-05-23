#pragma once

const auto skybox_vert = R"(
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(push_constant) uniform PushConstants {
    mat4 projection;
    mat4 modelView;
} pc;

layout(location = 0) in vec3 vsg_Vertex;
layout(location = 0) out vec3 UVW;

out gl_PerVertex{ vec4 gl_Position; };

void main()
{
    UVW = vsg_Vertex;

    // Remove translation
    mat4 modelView = pc.modelView;
    modelView[3] = vec4(0.0, 0.0, 0.0, 1.0);

    vec4 pos = pc.projection * modelView * vec4(vsg_Vertex, 1.0);
    gl_Position = vec4(pos.xy, 0.0, pos.w);
}
)";

const auto skybox_frag = R"(
#version 450
#extension GL_ARB_separate_shader_objects : enable

layout(binding = 0) uniform samplerCube envMap;
layout(location = 0) in vec3 UVW;
layout(location = 0) out vec4 outColor;

void main()
{
    outColor = textureLod(envMap, UVW, 0);
}
)";
