#version 450
#extension GL_ARB_separate_shader_objects : enable

#pragma import_defines (VSG_INSTANCE_POSITIONS)

layout(push_constant) uniform PushConstants {
    mat4 projection;
    mat4 modelView;
} pc;

layout(location = 0) in vec3 vsg_Vertex;
layout(location = 1) in vec3 vsg_Normal;
layout(location = 2) in vec2 vsg_TexCoord0;
layout(location = 3) in vec4 vsg_Color;

#ifdef VSG_INSTANCE_POSITIONS
layout(location = 4) in vec3 vsg_position;
#endif

layout(location = 0) out vec3 eyePos;
layout(location = 1) out vec3 normalDir;
layout(location = 2) out vec4 vertexColor;
layout(location = 3) out vec2 texCoord0;

layout(location = 5) out vec3 viewDir;
layout(location = 6) out vec3 lightDir;

out gl_PerVertex{ vec4 gl_Position; };

void main()
{
    vec4 vertex = vec4(vsg_Vertex, 1.0);

#ifdef VSG_INSTANCE_POSITIONS
   vertex.xyz = vertex.xyz + vsg_position;
#endif

    gl_Position = (pc.projection * pc.modelView) * vertex;

    eyePos = vec4(pc.modelView * vertex).xyz;
    normalDir = (pc.modelView * vec4(vsg_Normal, 0.0)).xyz;

    vec4 lpos = /*vsg_LightSource.position*/ vec4(0.0, 0.25, 1.0, 0.0);

    viewDir = -vec3(pc.modelView * vertex);

    if (lpos.w == 0.0)
        lightDir = lpos.xyz;
    else
        lightDir = lpos.xyz + viewDir;

    vertexColor = vsg_Color;
    texCoord0 = vsg_TexCoord0;
}
