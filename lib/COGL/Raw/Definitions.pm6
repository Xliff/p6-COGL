use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use GLib::Raw::Structs;
use GLib::Roles::Pointers;

unit package COGL::Raw::Definitions;

# Number of times I've had to force compile the whole project.
my constant forced = 203;

constant cogl       is export := 'cogl';
constant cogl-pango is export := 'cogl-pango';

constant CoglBool      is export := uint32;
constant CoglError     is export := GError;

constant CoglDebugObjectForeachTypeCallback is export := Pointer;
constant CoglFeatureCallback                is export := Pointer;
constant CoglUserDataDestroyCallback        is export := Pointer;
constant CoglPipelineLayerCallback          is export := Pointer;
constant CoglOnscreenDirtyCallback          is export := Pointer;
constant CoglOnscreenDirtyClosure           is export := Pointer;
constant CoglFrameCallback                  is export := Pointer;
constant CoglFrameClosure                   is export := Pointer;
constant CoglOutputCallback                 is export := Pointer;
constant CoglOnscreenResizeCallback         is export := Pointer;
constant CoglOnscreenResizeClosure          is export := Pointer;
constant CoglSwapBuffersNotify              is export := Pointer;
constant CoglOnscreenX11MaskCallback        is export := Pointer;

class CoglAttribute        is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglAttributeBuffer  is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglBitmap           is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglBuffer           is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglContext          is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglDisplay          is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglFrameBuffer      is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglFrameInfo        is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglHandle           is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglIndices          is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglIndexBuffer      is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglMaterial         is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglObject           is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglOffscreen        is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglOnscreen         is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglOnscreenTemplate is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglPangoFontMap     is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglPipeline         is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglPixelBuffer      is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglPrimitive        is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglOutput           is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglRenderer         is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglSource           is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglSnippet          is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglSwapChain        is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglTexture          is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglTexture2d        is repr('CPointer') is export does GLib::Roles::Pointers { }
class CoglTexture3d        is repr('CPointer') is export does GLib::Roles::Pointers { }

constant CoglTexture2D is export := CoglTexture2d;
constant CoglTexture3D is export := CoglTexture3d;