use v6.c;

use NativeCall;


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

sub cogl_is_texture (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_texture_error_quark ()
  returns guint
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_height (CoglTexture $texture)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_max_waste (CoglTexture $texture)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_width (CoglTexture $texture)
  returns gint
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
  guint $format, # CoglPixelFormat $format,
  gint $rowstride,
  CArray[uint8] $data,
  gint $level,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_texture_get_components (CoglTexture $texture)
  returns guint # CoglTextureComponents
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
  guint $components # CoglTextureComponents $components
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
