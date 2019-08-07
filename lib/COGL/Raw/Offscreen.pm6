use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Offscreen;

sub cogl_offscreen_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_offscreen_new_to_texture (CoglTexture $texture)
  returns CoglOffscreen
  is native(cogl)
  is export
{ * }

sub cogl_offscreen_new_with_texture (CoglTexture $texture)
  returns CoglOffscreen
  is native(cogl)
  is export
{ * }

sub cogl_offscreen_ref (void $offscreen)
  is native(cogl)
  is export
{ * }

sub cogl_offscreen_unref (void $offscreen)
  is native(cogl)
  is export
{ * }

sub cogl_is_offscreen (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }
