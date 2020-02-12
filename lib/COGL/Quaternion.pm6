use v6.c;

use Method::Also;
use NativeCall;

use COGL::Raw::Types;
use COGL::Raw::Quaternion;

class COGL::Quaternion {
  has CoglQuaternion $!cq;

  submethod BUILD (:$quaternion) {
    $!cq = $quaternion;
  }

  method COGL::Raw::Definitions::CoglQuaternion
    is also<CoglQuaternion>
  { $!cq }

  multi method new (CoglQuaternion $quaternion) {
    $quaternion ?? self.bless(:$quaternion) !! Nil;
  }

  multi method new (
    Num() $angle,
    Num() $x,
    Num() $y,
    Num() $z
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init($quaternion, $x, $y, $z);
    self.bless(:$quaternion);
  }

  method init (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    Num() $angle,
    Num() $x,
    Num() $y,
    Num() $z
  ) {
    my gfloat ($a, $xx, $yy, $zz) = ($a, $x, $y, $z);

    cogl_quaternion_init($q, $a, $xx, $yy, $zz);
  }

  multi method new (
    Num() $a,
    CArray[gfloat] $axis3f,
    :angle_vector(:angle-vector(:vector(:$angle))) is required
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init_from_angle_vector($quaternion, $a, $axis3f);
    self.bless(:$quaternion);
  }

  method init_from_angle_vector (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    Num() $angle,
    CArray[gfloat] $axis3f
  )
    is also<init-from-angle-vector>
  {
    my gfloat $a = $angle;

    cogl_quaternion_init_from_angle_vector($q, $a, $axis3f);
  }

  multi method new (
    CArray[gfloat] $a,
    :$array is required
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init_from_array($quaternion, $a);
    self.bless(:$quaternion);
  }

  method init_from_array (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    CArray[gfloat] $array
  )
    is also<init-from-array>
  {
    cogl_quaternion_init_from_array($q, $array);
  }

  my subset EulerOrObject of Mu where CoglEuler | COGL::Euler;
  multi method new (
    EulerOrObject $e,
    :$euler is required
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init_from_euler($quaternion, $e);
    self.bless(:$quaternion);
  }

  method init_from_euler (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    CoglEuler() $euler
  )
    is also<init-from-euler>
  {
    cogl_quaternion_init_from_euler($q, $euler);
  }

  my subset MatrixOrObject of Mu where CoglMatrix | COGL::Matrix;
  multi method new (
    MatrixOrObject $m,
    :$matrix is required
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init_from_matrix($quaternion, $m);
    self.bless(:$quaternion);
  }

  method init_from_matrix (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    CoglMatrix() $matrix
  )
    is also<init-from-matrix>
  {
    cogl_quaternion_init_from_matrix($q, $matrix);
  }

  my subset QuaternionOrObject of Mu where CoglQuaternion | COGL::Quaternion;
  multi method new (
    QuaternionOrObject $qq,
    :$quaternion is required
  ) {
    my $q = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $q;

    COGL::Quaternion.init_from_quaternion($q, $qq);
    self.bless(quaternion => $q);
  }

  method init_from_quaternion (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    CoglQuaternion() $src
  )
    is also<init-from-quaternion>
  {
    cogl_quaternion_init_from_quaternion($q, $src);
  }

  multi method new (
    Num() $angle,
    :x_rotation(:x-rotation(:$x)) is required
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init_from_x_rotation($quaternion, $angle);
    self.bless(:$quaternion);
  }

  method init_from_x_rotation (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    Num() $angle
  )
    is also<init-from-x-rotation>
  {
    my gfloat $a = $angle;

    cogl_quaternion_init_from_x_rotation($q, $a);
  }

  multi method new (
    Num() $angle,
    :y_rotation(:y-rotation(:$y)) is required
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init_from_x_rotation($quaternion, $angle);
    self.bless(:$quaternion);
  }

  method init_from_y_rotation (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    Num() $angle
  )
    is also<init-from-y-rotation>
  {
    my gfloat $a = $angle;

    cogl_quaternion_init_from_y_rotation($q, $a);
  }

  multi method new (
    Num() $angle,
    :z_rotation(:z-rotation(:$z)) is required
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init_from_x_rotation($quaternion, $angle);
    self.bless(:$quaternion);
  }

  method init_from_z_rotation (
    COGL::Quaternion:U:
    CoglQuaternion $q,
    Num() $angle
  )
    is also<init-from-z-rotation>
  {
    my gfloat $a = $angle;

    cogl_quaternion_init_from_z_rotation($q, $a);
  }

  multi method new (
    :identity(:$id) is required
  ) {
    my $quaternion = CoglQuaternion.new;

    die 'Cannot initialize CoglQuaternion!' unless $quaternion;

    COGL::Quaternion.init_identity($quaternion);
    self.bless(:$quaternion);
  }

  method init_identity (COGL::Quaternion:U: CoglQuaternion $q)
    is also<init-identity>
  {
    cogl_quaternion_init_identity($q);
  }

  method identity ( COGL::Quaternion:U: ) {
    cogl_get_static_identity_quaternion();
  }

  method zero ( COGL::Quaternion:U: ) {
    cogl_get_static_zero_quaternion();
  }

  method copy (:$raw = False) {
    my $q = cogl_quaternion_copy($!cq);

    $q ??
      ( $raw ?? $q !! COGL::Quaternion.new($q) )
      !!
      Nil;
  }

  method dot_product (CoglQuaternion() $b) is also<dot-product> {
    cogl_quaternion_dot_product($!cq, $b);
  }

  method equal (CoglQuaternion() $v2) {
    so cogl_quaternion_equal($!cq, $v2);
  }

  method free {
    cogl_quaternion_free($!cq);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_quaternion_get_gtype, $n, $t );
  }

  method get_rotation_angle is also<get-rotation-angle> {
    cogl_quaternion_get_rotation_angle($!cq);
  }

  method get_rotation_axis (gfloat $vector3) is also<get-rotation-axis> {
    cogl_quaternion_get_rotation_axis($!cq, $vector3);
  }

  multi method invert {
    COGL::Quaternion.invert($!cq);
    self;
  }
  multi method invert (COGL::Quaternion:U: CoglQuaternion $q) {
    cogl_quaternion_invert($q);
  }

  method multiply (
    CoglQuaternion() $right
  ) {
    cogl_quaternion_multiply($!cq, $!cq, $right);
    self;
  }

  method nlerp (
    CoglQuaternion() $b,
    Num() $t
  ) {
    my gfloat $tt = $t;

    cogl_quaternion_nlerp($!cq, self.copy(:raw), $b, $t);
    self;
  }

  method normalize {
    cogl_quaternion_normalize($!cq);
    self;
  }

  method pow (Num() $exponent) {
    my gfloat $e = $exponent;

    cogl_quaternion_pow($!cq, $e);
    self;
  }

  method slerp (
    CoglQuaternion() $b,
    Num() $t
  ) {
    my gfloat $tt = $t;

    cogl_quaternion_slerp($!cq, self.copy(:raw), $b, $tt);
    self;
  }

  method squad (
    CoglQuaternion() $prev,
    CoglQuaternion() $b,
    CoglQuaternion() $next,
    Num() $t
  ) {
    my gfloat $tt = $t;

    cogl_quaternion_squad($!cq, $prev, self.copy(:raw), $b, $next, $t);
    self;
  }

}
