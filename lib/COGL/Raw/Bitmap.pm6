use v6.c;

use NativeCall;

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

sub cogl_is_bitmap (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_error_quark ()
  returns uint32
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_buffer (CoglBitmap $bitmap)
  returns CoglPixelBuffer
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_format (CoglBitmap $bitmap)
  returns guint # CoglPixelFormat
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_height (CoglBitmap $bitmap)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_rowstride (CoglBitmap $bitmap)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_size_from_file (Str $filename, gint $width, gint $height)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_get_width (CoglBitmap $bitmap)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_bitmap_new_for_data (
  CoglContext $context,
  gint $width,
  gint $height,
  guint $format, # CoglPixelFormat $format,
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
