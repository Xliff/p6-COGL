use v6.c;

use NativeCall;


use COGL::Raw::Types;

unit package COGL::Raw::Renderer;

sub cogl_renderer_add_constraint (
  CoglRenderer $renderer,
  guint $constraint # CoglRendererConstraint $constraint
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

sub cogl_is_renderer (Pointer $object)
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
  returns uint32
  is native(cogl)
  is export
{ * }

sub cogl_renderer_foreach_output (
  CoglRenderer $renderer,
  &callback (CoglOutput, Pointer),
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
  returns gint
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
  guint $constraint # CoglRendererConstraint $constraint
)
  is native(cogl)
  is export
{ * }

sub cogl_renderer_get_driver (CoglRenderer $renderer)
  returns guint # CoglDriver
  is native(cogl)
  is export
{ * }

sub cogl_renderer_get_winsys_id (CoglRenderer $renderer)
  returns guint # CoglWinsysID
  is native(cogl)
  is export
{ * }

sub cogl_renderer_set_driver (
  CoglRenderer $renderer,
  guint # CoglDriver $driver
)
  is native(cogl)
  is export
{ * }

sub cogl_renderer_set_winsys_id (
  CoglRenderer $renderer,
  guint $winsys_id # CoglWinsysID $winsys_id
)
  is native(cogl)
  is export
{ * }
