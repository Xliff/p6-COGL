/* Strategy provided by p6-XML-LibXML:author<FROGGS> */
#ifdef _WIN32
#define DLLEXPORT __declspec(dllexport)
#else
#define DLLEXPORT extern
#endif

#include <cogl/cogl.h>
#include <cogl/cogl-object.h>
#include <cogl/cogl-egl.h>

#define s(name)     DLLEXPORT int sizeof_ ## name () { return sizeof(name); }

s(CoglColor)
s(CoglDepthState)
s(CoglEuler)
//s(CoglGLES2Vtable)
s(CoglMatrix)
s(CoglPollFD)
s(CoglOnscreenDirtyInfo)
s(CoglQuaternion)
s(CoglTextureVertex)
s(CoglUserDataKey)
s(CoglVertexP2)
s(CoglVertexP2C4)
s(CoglVertexP2T2)
s(CoglVertexP2T2C4)
s(CoglVertexP3)
s(CoglVertexP3C4)
s(CoglVertexP3T2)
s(CoglVertexP3T2C4)
