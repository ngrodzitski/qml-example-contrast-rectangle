#version 320 es
// ShaderEffect vertex shader (ES2-style semantics)

precision highp float;

layout(location = 0) in vec4 qt_Vertex;
layout(location = 1) in vec2 qt_MultiTexCoord0;
layout(set=0, binding = 0) uniform buf {
     mat4 qt_Matrix;     // Transformation matrix from item
} ubuf;

layout(location = 0) out vec2 qt_TexCoord0;

void main() {
    qt_TexCoord0 = qt_MultiTexCoord0;
    gl_Position  = ubuf.qt_Matrix * qt_Vertex;
}
