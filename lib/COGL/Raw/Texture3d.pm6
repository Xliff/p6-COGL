use v6.c;

use NativeCall;

use COGL::Raw::Types;

### /usr/include/cogl/cogl/cogl-texture-3d.h

sub cogl_is_texture_3d (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_texture_3d_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_texture_3d_new_from_bitmap (
  CoglBitmap $bitmap,
  gint $height,
  gint $depth
)
  returns CoglTexture3D
  is native(cogl)
  is export
{ * }

sub cogl_texture_3d_new_from_data (
  CoglContext $context,
  gint $width,
  gint $height,
  gint $depth,
  CoglPixelFormat $format,
  gint $rowstride,
  gint $image_stride,
  CArray[uint8] $data,
  CArray[Pointer[CoglError]] $error
)
  returns CoglTexture3D
  is native(cogl)
  is export
{ * }

sub cogl_texture_3d_new_with_size (
  CoglContext $context,
  gint $width,
  gint $height,
  gint $depth
)
  returns CoglTexture3D
  is native(cogl)
  is export
{ * }
