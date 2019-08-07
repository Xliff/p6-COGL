use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Texture2d;

sub cogl_is_texture_2d (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_texture_2d_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_texture_2d_new_from_bitmap (CoglBitmap $bitmap)
  returns CoglTexture2D
  is native(cogl)
  is export
{ * }

sub cogl_texture_2d_new_from_data (
  CoglContext $ctx, 
  gint $width, 
  gint $height, 
  CoglPixelFormat $format, 
  gint $rowstride, 
  uint8_t $data, 
  CArray[Pointer[CoglError]] $error
)
  returns CoglTexture2D
  is native(cogl)
  is export
{ * }

sub cogl_texture_2d_new_from_file (
  CoglContext $ctx, 
  Str $filename, 
  CArray[Pointer[CoglError]] $error
)
  returns CoglTexture2D
  is native(cogl)
  is export
{ * }

sub cogl_texture_2d_new_with_size (CoglContext $ctx, gint $width, gint $height)
  returns CoglTexture2D
  is native(cogl)
  is export
{ * }
