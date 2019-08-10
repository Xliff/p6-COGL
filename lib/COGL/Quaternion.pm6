use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Quaternion;

class COGL::Quaternion {
  has CoglQuaternion $!cq;

  method COGL::Raw::Types::CoglQuaternion
  { $!cq }

  method identity ( COGL::Quaternion:U: ) {
    cogl_get_static_identity_quaternion($!cq);
  }

  method zero ( COGL::Quaternion:U: ) {
    cogl_get_static_zero_quaternion($!cq);
  }

  method copy {
    cogl_quaternion_copy($!cq);
  }

  method dot_product (CoglQuaternion() $b) {
    cogl_quaternion_dot_product($!cq, $b);
  }

  method equal (CoglQuaternion() $v2) {
    cogl_quaternion_equal($!cq, $v2);
  }

  method free {
    cogl_quaternion_free($!cq);
  }

  method get_gtype {
    cogl_quaternion_get_gtype($!cq);
  }

  method get_rotation_angle {
    cogl_quaternion_get_rotation_angle($!cq);
  }

  method get_rotation_axis (gfloat $vector3) {
    cogl_quaternion_get_rotation_axis($!cq, $vector3);
  }

  method init (gfloat $angle, gfloat $x, gfloat $y, gfloat $z) {
    cogl_quaternion_init($!cq, $angle, $x, $y, $z);
  }

  method init_from_angle_vector (gfloat $angle, gfloat $axis3f) {
    cogl_quaternion_init_from_angle_vector($!cq, $angle, $axis3f);
  }

  method init_from_array (gfloat $array) {
    cogl_quaternion_init_from_array($!cq, $array);
  }

  method init_from_euler (CoglEuler() $euler) {
    cogl_quaternion_init_from_euler($!cq, $euler);
  }

  method init_from_matrix (CoglMatrix() $matrix) {
    cogl_quaternion_init_from_matrix($!cq, $matrix);
  }

  method init_from_quaternion (CoglQuaternion() $src) {
    cogl_quaternion_init_from_quaternion($!cq, $src);
  }

  method init_from_x_rotation (gfloat $angle) {
    cogl_quaternion_init_from_x_rotation($!cq, $angle);
  }

  method init_from_y_rotation (gfloat $angle) {
    cogl_quaternion_init_from_y_rotation($!cq, $angle);
  }

  method init_from_z_rotation (gfloat $angle) {
    cogl_quaternion_init_from_z_rotation($!cq, $angle);
  }

  method init_identity {
    cogl_quaternion_init_identity($!cq);
  }

  method invert {
    cogl_quaternion_invert($!cq);
  }

  method multiply (
    CoglQuaternion() $left,
    CoglQuaternion() $right
  ) {
    cogl_quaternion_multiply($!cq, $left, $right);
  }

  method nlerp (
    CoglQuaternion() $a,
    CoglQuaternion() $b,
    gfloat $t
  ) {
    cogl_quaternion_nlerp($!cq, $a, $b, $t);
  }

  method normalize {
    cogl_quaternion_normalize($!cq);
  }

  method pow (gfloat $exponent) {
    cogl_quaternion_pow($!cq, $exponent);
  }

  method slerp (
    CoglQuaternion() $a,
    CoglQuaternion() $b,
    gfloat $t
  ) {
    cogl_quaternion_slerp($!cq, $a, $b, $t);
  }

  method squad (
    CoglQuaternion() $prev,
    CoglQuaternion() $a,
    CoglQuaternion() $b,
    CoglQuaternion() $next,
    gfloat $t
  ) {
    cogl_quaternion_squad($!cq, $prev, $a, $b, $next, $t);
  }

}
