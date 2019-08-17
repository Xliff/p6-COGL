use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Display;

sub cogl_gdl_display_set_plane (
  CoglDisplay $display,
  gdl_plane_id_t $plane
)
  is native(cogl)
  is export
{ * }

sub cogl_is_display (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_display_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_display_get_renderer (CoglDisplay $display)
  returns CoglRenderer
  is native(cogl)
  is export
{ * }

sub cogl_display_new (
  CoglRenderer $renderer,
  CoglOnscreenTemplate $onscreen_template
)
  returns CoglDisplay
  is native(cogl)
  is export
{ * }

sub cogl_display_set_onscreen_template (
  CoglDisplay $display,
  CoglOnscreenTemplate $onscreen_template
)
  is native(cogl)
  is export
{ * }

sub cogl_display_setup (
  CoglDisplay $display,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }
