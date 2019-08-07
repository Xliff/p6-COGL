use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Renderer;

sub cogl_renderer_add_constraint (
  CoglRenderer $renderer, 
  CoglRendererConstraint $constraint
)
  is native(cogl)
  is export
{ * }

sub cogl_renderer_check_onscreen_template (
  CoglRenderer $renderer, 
  CoglOnscreenTemplate $onscreen_template, 
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_is_renderer (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_renderer_connect (
  CoglRenderer $renderer, 
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_renderer_error_quark ()
  returns uint32_t
  is native(cogl)
  is export
{ * }

sub cogl_renderer_foreach_output (
  CoglRenderer $renderer, 
  CoglOutputCallback $callback, 
  Pointer $user_data
)
  is native(cogl)
  is export
{ * }

sub cogl_renderer_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_renderer_get_n_fragment_texture_units (CoglRenderer $renderer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_renderer_new ()
  returns CoglRenderer
  is native(cogl)
  is export
{ * }

sub cogl_renderer_remove_constraint (
  CoglRenderer $renderer, 
  CoglRendererConstraint $constraint
)
  is native(cogl)
  is export
{ * }

sub cogl_renderer_get_driver (CoglRenderer $renderer)
  returns CoglDriver
  is native(cogl)
  is export
{ * }

sub cogl_renderer_get_winsys_id (CoglRenderer $renderer)
  returns CoglWinsysID
  is native(cogl)
  is export
{ * }

sub cogl_renderer_set_driver (CoglRenderer $renderer, CoglDriver $driver)
  is native(cogl)
  is export
{ * }

sub cogl_renderer_set_winsys_id (
  CoglRenderer $renderer, 
  CoglWinsysID $winsys_id
)
  is native(cogl)
  is export
{ * }
