use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Texture;

sub cogl_texture_allocate (
  CoglTexture $texture, 
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_is_texture (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_texture_error_quark ()
  returns uint32_t
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_height (CoglTexture $texture)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_max_waste (CoglTexture $texture)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_width (CoglTexture $texture)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_texture_is_sliced (CoglTexture $texture)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_texture_set_data (
  CoglTexture $texture, 
  CoglPixelFormat $format, 
  gint $rowstride, 
  uint8_t $data, 
  gint $level, 
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_components (CoglTexture $texture)
  returns CoglTextureComponents
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_premultiplied (CoglTexture $texture)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_texture_set_components (
  CoglTexture $texture, 
  CoglTextureComponents $components
)
  is native(cogl)
  is export
{ * }

sub cogl_texture_set_premultiplied (
  CoglTexture $texture, 
  CoglBool $premultiplied
)
  is native(cogl)
  is export
{ * }
