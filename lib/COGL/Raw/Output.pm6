use v6.c;

use NativeCall;


use COGL::Raw::Types;

unit package COGL::Raw::Output;

sub cogl_is_output (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_output_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_output_get_height (CoglOutput $output)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_output_get_mm_height (CoglOutput $output)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_output_get_mm_width (CoglOutput $output)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_output_get_refresh_rate (CoglOutput $output)
  returns gfloat
  is native(cogl)
  is export
{ * }

sub cogl_output_get_subpixel_order (CoglOutput $output)
  returns CoglSubpixelOrder
  is native(cogl)
  is export
{ * }

sub cogl_output_get_width (CoglOutput $output)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_output_get_x (CoglOutput $output)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_output_get_y (CoglOutput $output)
  returns gint
  is native(cogl)
  is export
{ * }
