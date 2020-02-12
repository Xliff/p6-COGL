use v6.c;

use Method::Also;
use NativeCall;


use COGL::Raw::Types;
use COGL::Raw::Matrix;



class COGL::Matrix {
  my @valid-origins = <identity quaternion array euler translation>;
  my $die-single-msg = qq:to/DIE/;
Must specify a SINGLE valid origin. The valid origins are:
  { @valid-origins.sort.join(', ') }
DIE

  has CoglMatrix $!cm handles<
    xx xy xz xw
    yx yy yz yw
    zx zy zz zw
    wx wy wz ww
  >;

  submethod BUILD (:$matrix) {
    $!cm = $matrix;
  }

  method COGL::Raw::Definitions::CoglMatrix
    is also<CoglMatrix>
  { $!cm }

  multi method new(CoglMatrix $matrix) {
    self.bless( :$matrix );
  }
  multi method new(*@params, *%origin) {
    die $die-single-msg  unless %origin.keys.all eq @valid-origins.any;
    die $die-single-msg  if     %origin.values.map( *.Int ).sum > 1;

    my $matrix = CoglMatrix.new;
    {
      when %origin<identity>.so {
        COGL::Matrix.init_identity($matrix);
      }

      when %origin<array>.so {
        COGL::Matrix.init_from_array($matrix, @params[0]);
      }

      when %origin<euler>.so {
        COGL::Matrix.init_from_euler($matrix, @params[0]);
      }

      when %origin<quaternion>.so {
        COGL::Matrix.init_from_quaternion($matrix, @params[0]);
      }

      when %origin<translation>.so {
        COGL::Matrix.init_from_translation($matrix |@params);
      }
    }
    self.bless( :$matrix );
  }

  method debug_matrix_print is also<debug-matrix-print> {
    cogl_debug_matrix_print($!cm);
  }

  method gtype_matrix_get_type is also<gtype-matrix-get-type> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_gtype_matrix_get_type, $n, $t );
  }

  method copy (COGL::Matrix:U: $matrix, :$raw = False) {
    my $m = cogl_matrix_copy($matrix);
    $raw ?? $m !! COGL::Matrix.new($m);
  }

  method equal (CoglMatrix() $v2) {
    so cogl_matrix_equal($!cm, $v2);
  }

  method free (COGL::Matrix:U: $freed) {
    cogl_matrix_free($freed);
  }

  method frustum (
    Num() $left,
    Num() $right,
    Num() $bottom,
    Num() $top,
    Num() $z_near,
    Num() $z_far
  ) {
    my gfloat ($l, $r, $b, $t, $zn, $zf) =
      ($left, $right, $bottom, $top, $z_near, $z_far);

    cogl_matrix_frustum($!cm, $l, $r, $b, $t, $zn, $zf);
  }

  method get_array (:$raw = False) is also<get-array> {
    my $a = cogl_matrix_get_array($!cm);
    return $a if $raw;
    my @a;
    @a[$_] = $a[$_] for ^16;  # 4x4
    @a;
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_matrix_get_gtype, $n, $t );
  }

  proto method get_inverse (|)
    is also<get-inverse>
  { * }

  multi method get_inverse (:$raw = False) {
    my $i = 0;
    COGL::Matrix.get_inverse($!cm, $i);
    $raw ?? $i !! COGL::Matrix.new($i);
  }
  multi method get_inverse (
    COGL::Matrix:U:
    CoglMatrix() $matrix, $inverse is rw
  ) {
    $inverse = CoglMatrix.new;
    cogl_matrix_get_inverse($!cm, $inverse);
  }

  method init_from_array (
    COGL::Matrix:U:
    CoglMatrix() $matrix,
    CArray[gfloat] $array
  )
    is also<init-from-array>
  {
    cogl_matrix_init_from_array($!cm, $array);
  }

  method init_from_euler (
    COGL::Matrix:U:
    CoglMatrix() $matrix,
    CoglEuler() $euler
  )
    is also<init-from-euler>
  {
    cogl_matrix_init_from_euler($!cm, $euler);
  }

  method init_from_quaternion (
    COGL::Matrix:U:
    CoglMatrix() $matrix,
    CoglQuaternion() $quaternion
  )
    is also<init-from-quaternion>
  {
    cogl_matrix_init_from_quaternion($matrix, $quaternion);
    $matrix;
  }

  method init_identity (COGL::Matrix:U: CoglMatrix() $matrix)
    is also<init-identity>
  {
    cogl_matrix_init_identity($matrix);
    $matrix;
  }

  method init_translation (
    COGL::Matrix:U:
    CoglMatrix() $matrix,
    Num() $tx,
    Num() $ty,
    Num() $tz
  )
    is also<init-translation>
  {
    my gfloat ($ttx, $tty, $ttz) = ($tx, $ty, $tz);

    cogl_matrix_init_translation($matrix, $ttx, $tty, $ttz);
  }

  method is_identity is also<is-identity> {
    cogl_matrix_is_identity($!cm);
  }

  method look_at (
    Num() $eye_position_x,
    Num() $eye_position_y,
    Num() $eye_position_z,
    Num() $object_x,
    Num() $object_y,
    Num() $object_z,
    Num() $world_up_x,
    Num() $world_up_y,
    Num() $world_up_z
  )
    is also<look-at>
  {
    my gfloat ($ex, $ey, $ez, $ox, $oy, $oz, $wx, $wy, $wz) = (
      $eye_position_x,
      $eye_position_y,
      $eye_position_z,
      $object_x,
      $object_y,
      $object_z,
      $world_up_x,
      $world_up_y,
      $world_up_z
    );

    cogl_matrix_look_at($!cm, $ex, $ey, $ez, $ox, $oy, $oz, $wx, $wy, $wz);
  }

  method multiply (CoglMatrix $a, CoglMatrix $b) {
    cogl_matrix_multiply($!cm, $a, $b);
  }

  method ortho (
    Num() $left,
    Num() $right,
    Num() $bottom,
    Num() $top,
    Num() $near,
    Num() $far
  ) {
    my gfloat ($l, $r, $b, $t, $n, $f) = (
      $left,
      $right,
      $bottom,
      $top,
      $near,
      $far
    );

    cogl_matrix_ortho($!cm, $l, $r, $b, $t, $n, $f);
  }

  method orthographic (
    Num() $x_1,
    Num() $y_1,
    Num() $x_2,
    Num() $y_2,
    Num() $near,
    Num() $far
  ) {
    my gfloat ($x1, $y1, $x2, $y2, $n, $f) = (
      $x_1,
      $y_1,
      $x_2,
      $y_2,
      $near,
      $far
    );

    cogl_matrix_orthographic($!cm, $x1, $y1, $x2, $y2, $n, $f);
  }

  method perspective (
    Num() $fov_y,
    Num() $aspect,
    Num() $z_near,
    Num() $z_far
  ) {
    my gfloat ($f, $a, $zf, $zn) = ($fov_y, $aspect, $z_near, $z_far);

    cogl_matrix_perspective($!cm, $fov_y, $aspect, $z_near, $z_far);
  }

  method project_points (
    Int()    $n_components,
    Int()    $stride_in,
    gpointer $points_in,
    Int()    $stride_out,
    gpointer $points_out,
    Int()    $n_points
  )
    is also<project-points>
  {
    my gint ($nc, $np) = ($n_components, $n_points);
    my size_t ($si, $so) = $stride_in, $stride_out;

    cogl_matrix_project_points(
      $!cm,
      $nc,
      $si,
      $points_in,
      $so,
      $points_out,
      $np
    );
  }

  method rotate (Num() $angle, Num() $x, Num() $y, Num() $z) {
    my gfloat ($a, $xx, $yy, $zz) = ($angle, $x, $y, $z);

    cogl_matrix_rotate($!cm, $a, $xx, $yy, $zz);
  }

  method rotate_euler (CoglEuler() $euler) is also<rotate-euler> {
    cogl_matrix_rotate_euler($!cm, $euler);
  }

  method rotate_quaternion (CoglQuaternion() $quaternion)
    is also<rotate-quaternion>
  {
    cogl_matrix_rotate_quaternion($!cm, $quaternion);
  }

  method scale (Num() $sx, Num() $sy, Num() $sz) {
    my gfloat ($ssx, $ssy, $ssz) = ($sx, $sy, $sz);

    cogl_matrix_scale($!cm, $sx, $sy, $sz);
  }

  method transform_point (Num() $x, Num() $y, Num() $z, Num() $w)
    is also<transform-point>
  {
    my gfloat ($xx, $yy, $zz, $ww) = ($x, $y, $z, $w);

    cogl_matrix_transform_point($!cm, $x, $y, $z, $w);
  }

  method transform_points (
    Int()    $n_components,
    Int()    $stride_in,
    gpointer $points_in,
    Int()    $stride_out,
    gpointer $points_out,
    Int()    $n_points
  )
    is also<transform-points>
  {
    my gint ($nc, $np) = ($n_components, $n_points);
    my size_t ($si, $so) = $stride_in, $stride_out;

    cogl_matrix_transform_points(
      $!cm,
      $nc,
      $si,
      $points_in,
      $so,
      $points_out,
      $np
    );
  }

  method translate (Num() $x, Num() $y, Num() $z) {
    my gfloat ($xx, $yy, $zz) = ($x, $y, $z);

    cogl_matrix_translate($!cm, $xx, $yy, $zz);
  }

  method transpose {
    cogl_matrix_transpose($!cm);
  }

  # Not aliased due to number in name
  method view_2d_in_frustum (
    Num() $left,
    Num() $right,
    Num() $bottom,
    Num() $top,
    Num() $z_near,
    Num() $z_2d,
    Num() $width_2d,
    Num() $height_2d
  ) {
    my gfloat ($l, $r, $b, $t, $z, $z2d, $w, $h) = (
      $left,
      $right,
      $bottom,
      $top,
      $z_near,
      $z_2d,
      $width_2d,
      $height_2d
    );

    cogl_matrix_view_2d_in_frustum($!cm, $l, $r, $b, $t, $z, $z2d, $w, $h);
  }

  # Not aliased due to number in name.
  method view_2d_in_perspective (
    Num() $fov_y,
    Num() $aspect,
    Num() $z_near,
    Num() $z_2d,
    Num() $width_2d,
    Num() $height_2d
  ) {
    my gfloat ($fy, $a, $z, $z2d, $w, $h) = (
      $fov_y,
      $aspect,
      $z_near,
      $z_2d,
      $width_2d,
      $height_2d
    );

    cogl_matrix_view_2d_in_perspective($!cm, $fy, $a, $z, $z2d, $w, $h);
  }

}
