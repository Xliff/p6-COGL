use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Euler;

sub cogl_euler_copy (CoglEuler $src)
  returns CoglEuler
  is native(cogl)
  is export
{ * }

sub cogl_euler_equal (void $v1, void $v2)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_euler_free (CoglEuler $euler)
  is native(cogl)
  is export
{ * }

sub cogl_euler_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_euler_init (
  CoglEuler $euler, 
  gfloat $heading, 
  gfloat $pitch, 
  gfloat $roll
)
  is native(cogl)
  is export
{ * }

sub cogl_euler_init_from_matrix (CoglEuler $euler, CoglMatrix $matrix)
  is native(cogl)
  is export
{ * }

sub cogl_euler_init_from_quaternion (
  CoglEuler $euler, 
  CoglQuaternion $quaternion
)
  is native(cogl)
  is export
{ * }
