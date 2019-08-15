use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Matrix;

sub cogl_debug_matrix_print (CoglMatrix $matrix)
  is native(cogl)
  is export
{ * }

sub cogl_gtype_matrix_get_type ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_matrix_copy (CoglMatrix $matrix)
  returns CoglMatrix
  is native(cogl)
  is export
{ * }

sub cogl_matrix_equal (CoglMatrix $v1, CoglMatrix $v2)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_matrix_free (CoglMatrix $matrix)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_frustum (
  CoglMatrix $matrix, 
  gfloat $left, 
  gfloat $right, 
  gfloat $bottom, 
  gfloat $top, 
  gfloat $z_near, 
  gfloat $z_far
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_get_array (CoglMatrix $matrix)
  returns CArray[gfloat]
  is native(cogl)
  is export
{ * }

sub cogl_matrix_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_matrix_get_inverse (CoglMatrix $matrix, CoglMatrix $inverse)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_matrix_init_from_array (CoglMatrix $matrix, gfloat $array)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_init_from_euler (CoglMatrix $matrix, CoglEuler $euler)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_init_from_quaternion (
  CoglMatrix $matrix, 
  CoglQuaternion $quaternion
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_init_identity (CoglMatrix $matrix)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_init_translation (
  CoglMatrix $matrix, 
  gfloat $tx, 
  gfloat $ty, 
  gfloat $tz
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_is_identity (CoglMatrix $matrix)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_matrix_look_at (
  CoglMatrix $matrix, 
  gfloat $eye_position_x, 
  gfloat $eye_position_y, 
  gfloat $eye_position_z, 
  gfloat $object_x, 
  gfloat $object_y, 
  gfloat $object_z, 
  gfloat $world_up_x, 
  gfloat $world_up_y, 
  gfloat $world_up_z
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_multiply (CoglMatrix $result, CoglMatrix $a, CoglMatrix $b)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_ortho (
  CoglMatrix $matrix, 
  gfloat $left, 
  gfloat $right, 
  gfloat $bottom, 
  gfloat $top, 
  gfloat $near, 
  gfloat $far
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_orthographic (
  CoglMatrix $matrix, 
  gfloat $x_1, 
  gfloat $y_1, 
  gfloat $x_2, 
  gfloat $y_2, 
  gfloat $near, 
  gfloat $far
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_perspective (
  CoglMatrix $matrix, 
  gfloat $fov_y, 
  gfloat $aspect, 
  gfloat $z_near, 
  gfloat $z_far
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_project_points (
  CoglMatrix $matrix, 
  gint $n_components, 
  size_t $stride_in, 
  Pointer $points_in, 
  size_t $stride_out, 
  Pointer $points_out, 
  gint $n_points
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_rotate (
  CoglMatrix $matrix, 
  gfloat $angle, 
  gfloat $x, 
  gfloat $y, 
  gfloat $z
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_rotate_euler (CoglMatrix $matrix, CoglEuler $euler)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_rotate_quaternion (
  CoglMatrix $matrix, 
  CoglQuaternion $quaternion
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_scale (CoglMatrix $matrix, gfloat $sx, gfloat $sy, gfloat $sz)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_transform_point (
  CoglMatrix $matrix, 
  gfloat $x, 
  gfloat $y, 
  gfloat $z, 
  gfloat $w
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_transform_points (
  CoglMatrix $matrix, 
  gint $n_components, 
  size_t $stride_in, 
  Pointer $points_in, 
  size_t $stride_out, 
  Pointer $points_out, 
  gint $n_points
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_translate (CoglMatrix $matrix, gfloat $x, gfloat $y, gfloat $z)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_transpose (CoglMatrix $matrix)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_view_2d_in_frustum (
  CoglMatrix $matrix, 
  gfloat $left, 
  gfloat $right, 
  gfloat $bottom, 
  gfloat $top, 
  gfloat $z_near, 
  gfloat $z_2d, 
  gfloat $width_2d, 
  gfloat $height_2d
)
  is native(cogl)
  is export
{ * }

sub cogl_matrix_view_2d_in_perspective (
  CoglMatrix $matrix, 
  gfloat $fov_y, 
  gfloat $aspect, 
  gfloat $z_near, 
  gfloat $z_2d, 
  gfloat $width_2d, 
  gfloat $height_2d
)
  is native(cogl)
  is export
{ * }
