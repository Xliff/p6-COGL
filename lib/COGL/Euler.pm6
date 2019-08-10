use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Euler;

class COGL::Euler {
  has CoglEuler $!ce;
  
  method COGL::Raw::Types::CoglEuler 
  { $!ce }
  
  method init (Num() $heading, Num() $pitch, Num() $roll) {
    my gfloat ($h, $p, $r) = ($heading, $pitch, $roll);
    cogl_euler_init($!ce, $h, $p, $r);
  }

  method init_from_matrix (CoglMatrix() $matrix) {
    cogl_euler_init_from_matrix($!ce, $matrix);
  }

  method init_from_quaternion (CoglQuaternion() $quaternion) {
    cogl_euler_init_from_quaternion($!ce, $quaternion);
  }
  
  method copy {
    cogl_euler_copy($!ce);
  }

  method equal (CoglEuler() $v2) {
    cogl_euler_equal($!ce, $v2);
  }

  method free {
    cogl_euler_free($!ce);
  }

  method get_gtype {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_euler_get_gtype, $n, $t );
  }

}
