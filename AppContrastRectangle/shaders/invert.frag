#version 320 es
// ShaderEffect fragment shader (ES2-style semantics)
precision highp float;

layout(location = 0) in vec2 qt_TexCoord0;
layout(set=0, binding=1) uniform sampler2D source;
layout(set=0, binding = 0) uniform buf {
     mat4 qt_Matrix;     // Transformation matrix from item
} ubuf;

layout(location = 0) out vec4 fragColor;

void main() {
    vec4 under = texture(source, qt_TexCoord0);
    fragColor = vec4(vec3(1.0) - under.rgb, under.a);
}
