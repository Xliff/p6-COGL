use v6.c;

use NativeCall;

use GTK::Compat::Types;
use GTK::Roles::Pointers;

unit package COGL::Raw::Types;

class CoglAttribute       is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglAttributeBuffer is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglBuffer          is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglContext         is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglDisplay         is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglFramebuffer     is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglHandle          is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglMaterial        is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglObject          is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglOffscreen       is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglOnScreen        is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglPipeline        is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglPrimative       is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglTexture         is repr('CPointer') is export does GTK::Roles::Pointers { }
class CoglTexture2D       is repr('CPointer') is export does GTK::Roles::Pointers { }

constant CoglBool      is export := gint;
constant CoglTexture2d is export := CoglTexture2D;

class CoglVertexP2 is repr<CStruct>      also does GTK::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
}

class CoglVertexP3 is repr<CStruct>      also does GTK::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
}

class CoglVertexP2C4 is repr<CStruct>    also does GTK::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has uint8  $.r is rw;
  has uint8  $.g is rw;
  has uint8  $.b is rw;
  has uint8  $.a is rw;
}

class CoglVertexP3C4 is repr<CStruct>    also does GTK::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
  has uint8  $.r is rw;
  has uint8  $.g is rw;
  has uint8  $.b is rw;
  has uint8  $.a is rw;
}

class CoglVertexP2T2 is repr<CStruct>    also does GTK::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.s is rw;
  has gfloat $.t is rw;
}

class CoglVertexP3T2 is repr<CStruct>    also does GTK::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
  has gfloat $.s is rw;
  has gfloat $.t is rw;
}

class CoglVertexP2T2C4 is repr<CStruct>  also does GTK::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.s is rw;
  has gfloat $.t is rw;
  has uint8  $.r is rw;
  has uint8  $.g is rw;
  has uint8  $.b is rw;
  has uint8  $.a is rw;
}

class CoglVertexP3T2C$ is repr<CStruct>  also does GTK::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
  has gfloat $.s is rw;
  has gfloat $.t is rw;
  has uint8  $.r is rw;
  has uint8  $.g is rw;
  has uint8  $.b is rw;
  has uint8  $.a is rw;
}

our enum CoglAttributeType is export (
  COGL_ATTRIBUTE_TYPE_BYTE           => 0x1400,
  COGL_ATTRIBUTE_TYPE_UNSIGNED_BYTE  => 0x1401,
  COGL_ATTRIBUTE_TYPE_SHORT          => 0x1402,
  COGL_ATTRIBUTE_TYPE_UNSIGNED_SHORT => 0x1403,
  COGL_ATTRIBUTE_TYPE_FLOAT          => 0x1406,
);

our enum CoglBitmapError is export <
  COGL_BITMAP_ERROR_FAILED
  COGL_BITMAP_ERROR_UNKNOWN_TYPE
  COGL_BITMAP_ERROR_CORRUPT_IMAGE
>;

our enum CoglBlendStringError is export <
  COGL_BLEND_STRING_ERROR_PARSE_ERROR
  COGL_BLEND_STRING_ERROR_ARGUMENT_PARSE_ERROR
  COGL_BLEND_STRING_ERROR_INVALID_ERROR
  COGL_BLEND_STRING_ERROR_GPU_UNSUPPORTED_ERROR
>;

our enum CoglBufferError is export <
  COGL_BUFFER_ERROR_MAP
>;

our enum CoglBufferMapHint is export (
  COGL_BUFFER_MAP_HINT_DISCARD       => 1 +< 0,
  COGL_BUFFER_MAP_HINT_DISCARD_RANGE => 1 +< 1,
);

our enum CoglBufferUpdateHint is export <
  COGL_BUFFER_UPDATE_HINT_STATIC
  COGL_BUFFER_UPDATE_HINT_DYNAMIC
  COGL_BUFFER_UPDATE_HINT_STREAM
>;

our enum CoglDepthTestFunction is export (
  COGL_DEPTH_TEST_FUNCTION_NEVER    =>  0x0200,
  COGL_DEPTH_TEST_FUNCTION_LESS     =>  0x0201,
  COGL_DEPTH_TEST_FUNCTION_EQUAL    =>  0x0202,
  COGL_DEPTH_TEST_FUNCTION_LEQUAL   =>  0x0203,
  COGL_DEPTH_TEST_FUNCTION_GREATER  =>  0x0204,
  COGL_DEPTH_TEST_FUNCTION_NOTEQUAL =>  0x0205,
  COGL_DEPTH_TEST_FUNCTION_GEQUAL   =>  0x0206,
  COGL_DEPTH_TEST_FUNCTION_ALWAYS   =>  0x0207,
);

our enum CoglFilterReturn is export <
  COGL_FILTER_CONTINUE
  COGL_FILTER_REMOVE
>;

our enum CoglFogMode is export <
  COGL_FOG_MODE_LINEAR
  COGL_FOG_MODE_EXPONENTIAL
  COGL_FOG_MODE_EXPONENTIAL_SQUARED
>;

our enum CoglFrameEvent is export (
  COGL_FRAME_EVENT_SYNC =>  1,
  'COGL_FRAME_EVENT_COMPLETE'
);

our enum CoglFramebufferError is export <
  COGL_FRAMEBUFFER_ERROR_ALLOCATE
>;

our enum CoglIndicesType is export <
  COGL_INDICES_TYPE_UNSIGNED_BYTE
  COGL_INDICES_TYPE_UNSIGNED_SHORT
  COGL_INDICES_TYPE_UNSIGNED_INT
>;

our enum CoglMaterialAlphaFunc is export (
  COGL_MATERIAL_ALPHA_FUNC_NEVER    =>  0x0200,
  COGL_MATERIAL_ALPHA_FUNC_LESS     =>  0x0201,
  COGL_MATERIAL_ALPHA_FUNC_EQUAL    =>  0x0202,
  COGL_MATERIAL_ALPHA_FUNC_LEQUAL   =>  0x0203,
  COGL_MATERIAL_ALPHA_FUNC_GREATER  =>  0x0204,
  COGL_MATERIAL_ALPHA_FUNC_NOTEQUAL =>  0x0205,
  COGL_MATERIAL_ALPHA_FUNC_GEQUAL   =>  0x0206,
  COGL_MATERIAL_ALPHA_FUNC_ALWAYS   =>  0x0207,
);

our enum CoglMaterialFilter is export (
  COGL_MATERIAL_FILTER_NEAREST                =>  0x2600,
  COGL_MATERIAL_FILTER_LINEAR                 =>  0x2601,
  COGL_MATERIAL_FILTER_NEAREST_MIPMAP_NEAREST =>  0x2700,
  COGL_MATERIAL_FILTER_LINEAR_MIPMAP_NEAREST  =>  0x2701,
  COGL_MATERIAL_FILTER_NEAREST_MIPMAP_LINEAR  =>  0x2702,
  COGL_MATERIAL_FILTER_LINEAR_MIPMAP_LINEAR   =>  0x2703,
);

our enum CoglMaterialLayerType is export <
  COGL_MATERIAL_LAYER_TYPE_TEXTURE
>;

our enum CoglPipelineAlphaFunc is export (
  COGL_PIPELINE_ALPHA_FUNC_NEVER    =>  0x0200,
  COGL_PIPELINE_ALPHA_FUNC_LESS     =>  0x0201,
  COGL_PIPELINE_ALPHA_FUNC_EQUAL    =>  0x0202,
  COGL_PIPELINE_ALPHA_FUNC_LEQUAL   =>  0x0203,
  COGL_PIPELINE_ALPHA_FUNC_GREATER  =>  0x0204,
  COGL_PIPELINE_ALPHA_FUNC_NOTEQUAL =>  0x0205,
  COGL_PIPELINE_ALPHA_FUNC_GEQUAL   =>  0x0206,
  COGL_PIPELINE_ALPHA_FUNC_ALWAYS   =>  0x0207,
);

our enum CoglPipelineCullFaceMode is export <
  COGL_PIPELINE_CULL_FACE_MODE_NONE
  COGL_PIPELINE_CULL_FACE_MODE_FRONT
  COGL_PIPELINE_CULL_FACE_MODE_BACK
  COGL_PIPELINE_CULL_FACE_MODE_BOTH
>;

our enum CoglPipelineFilter is export (
  COGL_PIPELINE_FILTER_NEAREST                =>  0x2600,
  COGL_PIPELINE_FILTER_LINEAR                 =>  0x2601,
  COGL_PIPELINE_FILTER_NEAREST_MIPMAP_NEAREST =>  0x2700,
  COGL_PIPELINE_FILTER_LINEAR_MIPMAP_NEAREST  =>  0x2701,
  COGL_PIPELINE_FILTER_NEAREST_MIPMAP_LINEAR  =>  0x2702,
  COGL_PIPELINE_FILTER_LINEAR_MIPMAP_LINEAR   =>  0x2703,
);

our enum CoglRendererError is export <
  COGL_RENDERER_ERROR_XLIB_DISPLAY_OPEN
  COGL_RENDERER_ERROR_BAD_CONSTRAINT
>;

our enum CoglShaderType is export <
  COGL_SHADER_TYPE_VERTEX
  COGL_SHADER_TYPE_FRAGMENT
>;

our enum CoglSnippetHook is export (
  COGL_SNIPPET_HOOK_VERTEX                  =>  0,
  'COGL_SNIPPET_HOOK_VERTEX_TRANSFORM',
  'COGL_SNIPPET_HOOK_VERTEX_GLOBALS',
  'COGL_SNIPPET_HOOK_POINT_SIZE',
  COGL_SNIPPET_HOOK_FRAGMENT                =>  2048,
  'COGL_SNIPPET_HOOK_FRAGMENT_GLOBALS',
  COGL_SNIPPET_HOOK_TEXTURE_COORD_TRANSFORM =>  4096,
  COGL_SNIPPET_HOOK_LAYER_FRAGMENT          =>  6144,
  'COGL_SNIPPET_HOOK_TEXTURE_LOOKUP'
);

our enum CoglStereoMode is export <
  COGL_STEREO_BOTH
  COGL_STEREO_LEFT
  COGL_STEREO_RIGHT
>;

our enum CoglSubpixelOrder is export <
  COGL_SUBPIXEL_ORDER_UNKNOWN
  COGL_SUBPIXEL_ORDER_NONE
  COGL_SUBPIXEL_ORDER_HORIZONTAL_RGB
  COGL_SUBPIXEL_ORDER_HORIZONTAL_BGR
  COGL_SUBPIXEL_ORDER_VERTICAL_RGB
  COGL_SUBPIXEL_ORDER_VERTICAL_BGR
>;

our enum CoglSystemError is export <
  COGL_SYSTEM_ERROR_UNSUPPORTED
  COGL_SYSTEM_ERROR_NO_MEMORY
>;

our enum CoglTextureComponents is export (
  COGL_TEXTURE_COMPONENTS_A =>  1,
  'COGL_TEXTURE_COMPONENTS_RG',
  'COGL_TEXTURE_COMPONENTS_RGB',
  'COGL_TEXTURE_COMPONENTS_RGBA',
  'COGL_TEXTURE_COMPONENTS_DEPTH'
);

our enum CoglTextureError is export <
    COGL_TEXTURE_ERROR_SIZE
    COGL_TEXTURE_ERROR_FORMAT
    COGL_TEXTURE_ERROR_BAD_PARAMETER
    COGL_TEXTURE_ERROR_TYPE
>;

our enum CoglTextureFlags is export (
  COGL_TEXTURE_NONE           =>  0,
  COGL_TEXTURE_NO_AUTO_MIPMAP =>  1 +< 0,
  COGL_TEXTURE_NO_SLICING     =>  1 +< 1,
  COGL_TEXTURE_NO_ATLAS       =>  1 +< 2,
);

our enum CoglVerticesMode is export (
  COGL_VERTICES_MODE_POINTS         =>  0x0000,
  COGL_VERTICES_MODE_LINES          =>  0x0001,
  COGL_VERTICES_MODE_LINE_LOOP      =>  0x0002,
  COGL_VERTICES_MODE_LINE_STRIP     =>  0x0003,
  COGL_VERTICES_MODE_TRIANGLES      =>  0x0004,
  COGL_VERTICES_MODE_TRIANGLE_STRIP =>  0x0005,
  COGL_VERTICES_MODE_TRIANGLE_FAN   =>  0x0006,
);

our enum CoglWinding is export <
  COGL_WINDING_CLOCKWISE
  COGL_WINDING_COUNTER_CLOCKWISE
>;

our enum CoglWinsysFeature is export <
  COGL_WINSYS_FEATURE_MULTIPLE_ONSCREEN
  COGL_WINSYS_FEATURE_SWAP_THROTTLE
  COGL_WINSYS_FEATURE_VBLANK_COUNTER
  COGL_WINSYS_FEATURE_VBLANK_WAIT
  COGL_WINSYS_FEATURE_TEXTURE_FROM_PIXMAP
  COGL_WINSYS_FEATURE_SWAP_BUFFERS_EVENT
  COGL_WINSYS_FEATURE_SWAP_REGION
  COGL_WINSYS_FEATURE_SWAP_REGION_THROTTLE
  COGL_WINSYS_FEATURE_SWAP_REGION_SYNCHRONIZED
  COGL_WINSYS_FEATURE_BUFFER_AGE
  COGL_WINSYS_FEATURE_SYNC_AND_COMPLETE_EVENT
  COGL_WINSYS_FEATURE_N_FEATURES
>;

our enum CoglWinsysID is export <
  COGL_WINSYS_ID_ANY
  COGL_WINSYS_ID_STUB
  COGL_WINSYS_ID_GLX
  COGL_WINSYS_ID_EGL_XLIB
  COGL_WINSYS_ID_EGL_NULL
  COGL_WINSYS_ID_EGL_GDL
  COGL_WINSYS_ID_EGL_WAYLAND
  COGL_WINSYS_ID_EGL_KMS
  COGL_WINSYS_ID_EGL_ANDROID
  COGL_WINSYS_ID_EGL_MIR
  COGL_WINSYS_ID_WGL
  COGL_WINSYS_ID_SDL
>;

our enum CoglColorBits (
  COGL_A_BIT       => (1 +< 4),
  COGL_BGR_BIT     => (1 +< 5),
  COGL_AFIRST_BIT  => (1 +< 6),
  COGL_PREMULT_BIT => (1 +< 7),
  COGL_DEPTH_BIT   => (1 +< 8),
  COGL_STENCIL_BIT => (1 +< 9),
);

our enum CoglPixelFormat is export (
  COGL_PIXEL_FORMAT_ANY           => 0,
  COGL_PIXEL_FORMAT_A_8           => 1 +| COGL_A_BIT,

  COGL_PIXEL_FORMAT_RGB_565       => 4,
  COGL_PIXEL_FORMAT_RGBA_4444     => 5 +| COGL_A_BIT,
  COGL_PIXEL_FORMAT_RGBA_5551     => 6 +| COGL_A_BIT,
  COGL_PIXEL_FORMAT_YUV           => 7,
  COGL_PIXEL_FORMAT_G_8           => 8,

  COGL_PIXEL_FORMAT_RG_88         => 9,

  COGL_PIXEL_FORMAT_RGB_888       => 2,
  COGL_PIXEL_FORMAT_BGR_888       => (2 +| COGL_BGR_BIT),

  COGL_PIXEL_FORMAT_RGBA_8888     => (3 +| COGL_A_BIT),
  COGL_PIXEL_FORMAT_BGRA_8888     => (3 +| COGL_A_BIT +| COGL_BGR_BIT),
  COGL_PIXEL_FORMAT_ARGB_8888     => (3 +| COGL_A_BIT +| COGL_AFIRST_BIT),
  COGL_PIXEL_FORMAT_ABGR_8888     => (3 +| COGL_A_BIT +| COGL_BGR_BIT +| COGL_AFIRST_BIT),

  COGL_PIXEL_FORMAT_RGBA_1010102  => (13 +| COGL_A_BIT),
  COGL_PIXEL_FORMAT_BGRA_1010102  => (13 +| COGL_A_BIT +| COGL_BGR_BIT),
  COGL_PIXEL_FORMAT_ARGB_2101010  => (13 +| COGL_A_BIT +| COGL_AFIRST_BIT),
  COGL_PIXEL_FORMAT_ABGR_2101010  => (13 +| COGL_A_BIT +| COGL_BGR_BIT +| COGL_AFIRST_BIT),

  COGL_PIXEL_FORMAT_RGBA_8888_PRE => (3 +| COGL_A_BIT +| COGL_PREMULT_BIT),
  COGL_PIXEL_FORMAT_BGRA_8888_PRE => (3 +| COGL_A_BIT +| COGL_PREMULT_BIT +| COGL_BGR_BIT),
  COGL_PIXEL_FORMAT_ARGB_8888_PRE => (3 +| COGL_A_BIT +| COGL_PREMULT_BIT +| COGL_AFIRST_BIT),
  COGL_PIXEL_FORMAT_ABGR_8888_PRE => (3 +| COGL_A_BIT +| COGL_PREMULT_BIT +| COGL_BGR_BIT +| COGL_AFIRST_BIT),
  COGL_PIXEL_FORMAT_RGBA_4444_PRE => (21 +| COGL_A_BIT +| COGL_PREMULT_BIT),
  COGL_PIXEL_FORMAT_RGBA_5551_PRE => (22 +| COGL_A_BIT +| COGL_PREMULT_BIT),

  COGL_PIXEL_FORMAT_RGBA_1010102_PRE => (29  +| COGL_PREMULT_BIT),
  COGL_PIXEL_FORMAT_BGRA_1010102_PRE => (61  +| COGL_PREMULT_BIT),
  COGL_PIXEL_FORMAT_ARGB_2101010_PRE => (93  +| COGL_PREMULT_BIT),
  COGL_PIXEL_FORMAT_ABGR_2101010_PRE => (125 +| COGL_PREMULT_BIT),

  COGL_PIXEL_FORMAT_DEPTH_16  => (9 +| COGL_DEPTH_BIT),
  COGL_PIXEL_FORMAT_DEPTH_32  => (3 +| COGL_DEPTH_BIT),

  COGL_PIXEL_FORMAT_DEPTH_24_STENCIL_8 => (3 +| COGL_DEPTH_BIT +| COGL_STENCIL_BIT)
);