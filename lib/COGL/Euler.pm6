use v6.c;

use Method::Also;

use COGL::Raw::Types;
use COGL::Raw::Euler;

use COGL::Matrix;
use COGL::Quaternion;

class COGL::Euler {
  has CoglEuler $!ce;

  submethod BLESS (:$euler) {
    $!ce = $euler;
  }

  method COGL::Raw::Types::CoglEuler
    is also<CoglEuler>
  { $!ce }

  multi method new (CoglEuler $euler) {
    $euler ?? self.bless(:$euler) !! Nil;
  }
  multi method new (Num() $heading, Num() $pitch, Num() $roll) {
    my $euler = CoglEuler.new;

    die 'Could not init CoglEuler!' unless $euler;

    COGL::Euler.init($euler, $heading, $pitch, $roll);
    self.bless(:$euler);
  }
  multi method new ($param) {
    my $euler = CoglEuler.new;

    die 'Could not init CoglEuler!' unless $euler;

    given $param {
      when COGL::Matrix     { $_ = .CoglMatrix;     proceed         }
      when COGL::Quaternion { $_ = .CoglQuaternion; proceed         }
      when CoglMatrix       { self.init_from_matrix($euler, $_)     }
      when CoglQuaternion   { self.init_from_quaternion($euler, $_) }

      default {
        die "Invalid value { .^name } passed as \$param!";
      }
    }

    self.bless(:$euler);
  }

  method init (
    COGL::Euler:U:
    CoglEuler $e,
    Num() $heading,
    Num() $pitch,
    Num() $roll
  ) {
    my gfloat ($h, $p, $r) = ($heading, $pitch, $roll);

    cogl_euler_init($e, $h, $p, $r);
  }

  method init_from_matrix (
    COGL::Euler:U:
    CoglEuler $e,
    CoglMatrix() $matrix
  )
    is also<init-from-matrix>
  {
    cogl_euler_init_from_matrix($e, $matrix);
  }

  method init_from_quaternion (
    COGL::Euler:U:
    CoglEuler $e,
    CoglQuaternion() $quaternion
  )
    is also<init-from-quaternion>
  {
    cogl_euler_init_from_quaternion($e, $quaternion);
  }

  multi method copy (:$raw = False) {
    my $c = COGL::Euler.copy($!ce);

    $c ??
      ( $raw ?? $c !! COGL::Euler.new($c) )
      !!
      Nil
  }
  multi method copy (COGL::Euler:U: CoglEuler $e) {
    cogl_euler_copy($e);
  }

  multi method equal (CoglEuler() $v2) {
    COGL::Euler.equal($!ce, $v2);
  }
  multi method equal (COGL::Euler:U: CoglEuler $e1, CoglEuler $e2) {
    so cogl_euler_equal($e1, $e2);
  }

  method free {
    cogl_euler_free($!ce);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_euler_get_gtype, $n, $t );
  }

}
