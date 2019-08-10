use v6.c;

use NativeCall;

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

sub cogl_offscreen_ref (CoglOffscreen $offscreen)
  is native(cogl)
  is export
{ * }

sub cogl_offscreen_unref (CoglOffscreen $offscreen)
  is native(cogl)
  is export
{ * }

sub cogl_is_offscreen (gpointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }
