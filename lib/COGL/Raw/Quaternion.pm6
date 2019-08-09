use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Quaternion;

sub cogl_get_static_identity_quaternion ()
  returns CoglQuaternion
  is native(cogl)
  is export
{ * }

sub cogl_get_static_zero_quaternion ()
  returns CoglQuaternion
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_copy (CoglQuaternion $src)
  returns CoglQuaternion
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_dot_product (CoglQuaternion $a, CoglQuaternion $b)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_equal (void $v1, void $v2)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_free (CoglQuaternion $quaternion)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_get_rotation_angle (CoglQuaternion $quaternion)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_get_rotation_axis (
  CoglQuaternion $quaternion, 
  gfloat $vector3
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init (
  CoglQuaternion $quaternion, 
  gfloat $angle, 
  gfloat $x, 
  gfloat $y, 
  gfloat $z
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_from_angle_vector (
  CoglQuaternion $quaternion, 
  gfloat $angle, 
  gfloat $axis3f
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_from_array (
  CoglQuaternion $quaternion, 
  gfloat $array
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_from_euler (
  CoglQuaternion $quaternion, 
  CoglEuler $euler
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_from_matrix (
  CoglQuaternion $quaternion, 
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_from_quaternion (
  CoglQuaternion $quaternion, 
  CoglQuaternion $src
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_from_x_rotation (
  CoglQuaternion $quaternion, 
  gfloat $angle
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_from_y_rotation (
  CoglQuaternion $quaternion, 
  gfloat $angle
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_from_z_rotation (
  CoglQuaternion $quaternion, 
  gfloat $angle
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_init_identity (CoglQuaternion $quaternion)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_invert (CoglQuaternion $quaternion)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_multiply (
  CoglQuaternion $result, 
  CoglQuaternion $left, 
  CoglQuaternion $right
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_nlerp (
  CoglQuaternion $result, 
  CoglQuaternion $a, 
  CoglQuaternion $b, 
  gfloat $t
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_normalize (CoglQuaternion $quaternion)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_pow (CoglQuaternion $quaternion, gfloat $exponent)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_slerp (
  CoglQuaternion $result, 
  CoglQuaternion $a, 
  CoglQuaternion $b, 
  gfloat $t
)
  is native(cogl)
  is export
{ * }

sub cogl_quaternion_squad (
  CoglQuaternion $result, 
  CoglQuaternion $prev, 
  CoglQuaternion $a, 
  CoglQuaternion $b, 
  CoglQuaternion $next, 
  gfloat $t
)
  is native(cogl)
  is export
{ * }
