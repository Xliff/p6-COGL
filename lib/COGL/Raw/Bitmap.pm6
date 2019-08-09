use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Bitmap;

# sub cogl_android_bitmap_new_from_asset (
#   CoglContext $context, 
#   AAssetManager $manager, 
#   Str $filename, 
#   CoglError $error
# )
#   returns CoglBitmap
#   is native(cogl)
#   is export
# { * }

sub cogl_is_bitmap (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_error_quark ()
  returns uint32_t
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_buffer (CoglBitmap $bitmap)
  returns CoglPixelBuffer
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_format (CoglBitmap $bitmap)
  returns CoglPixelFormat
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_height (CoglBitmap $bitmap)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_rowstride (CoglBitmap $bitmap)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_size_from_file (Str $filename, gint $width, gint $height)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_width (CoglBitmap $bitmap)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_new_for_data (
  CoglContext $context, 
  gint $width, 
  gint $height, 
  CoglPixelFormat $format, 
  gint $rowstride, 
  CArray[uint8] $data
)
  returns CoglBitmap
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_new_from_buffer (
  CoglBuffer $buffer, 
  uint8 $format, # CoglPixelFormat $format, 
  gint $width, 
  gint $height, 
  gint $rowstride, 
  gint $offset
)
  returns CoglBitmap
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_new_from_file (
  Str $filename, 
  CArray[Pointer[CoglError]] $error
)
  returns CoglBitmap
  is native(cogl)
  is export
{ * }
