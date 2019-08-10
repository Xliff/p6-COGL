use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Color;

class COGL::Color {
  has CoglColor $!cc;

  submethod BUILD (:$color) {
    $!cc = $color;
  }

  method COGL::Raw::Types::CoglColor
  { $!cc }

  multi method new (CoglColor $color) {
    self.bless(:$color);
  }
  multi method new {
    self.bless( color => cogl_color_new() );
  }

  method alpha is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_alpha($!cc);
      },
      STORE => sub ($, Num() $alpha is copy) {
        my gfloat $a = $alpha;
        cogl_color_set_alpha($!cc, $a);
      }
    );
  }

  method alpha_byte is rw is also<alpha-byte> {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_alpha_byte($!cc);
      },
      STORE => sub ($, Int() $alpha is copy) {
        my uint8 $a = resolve-uint8($alpha);
        cogl_color_set_alpha_byte($!cc, $a);
      }
    );
  }

  method blue is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_blue($!cc);
      },
      STORE => sub ($, Num() $blue is copy) {
        my gfloat $b = $blue;
        cogl_color_set_blue($!cc, $b);
      }
    );
  }

  method blue_byte is rw is also<blue-byte> {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_blue_byte($!cc);
      },
      STORE => sub ($, Int() $blue is copy) {
        my uint8 $b = resolve-uint8($blue);
        cogl_color_set_blue_byte($!cc, $blue);
      }
    );
  }

  method green is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_green($!cc);
      },
      STORE => sub ($, Num() $green is copy) {
        my gfloat $g = $green;
        cogl_color_set_green($!cc, $g);
      }
    );
  }

  method green_byte is rw is also<green-byte> {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_green_byte($!cc);
      },
      STORE => sub ($, $green is copy) {
        my uint8 $g = resolve-uint8($green);
        cogl_color_set_green_byte($!cc, $green);
      }
    );
  }

  method red is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_red($!cc);
      },
      STORE => sub ($, Num() $red is copy) {
        my gfloat $r = $red;
        cogl_color_set_red($!cc, $r);
      }
    );
  }

  method red_byte is rw is also<red-byte> {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_red_byte($!cc);
      },
      STORE => sub ($, Int() $red is copy) {
        my uint8 $r = resolve-uint8($red);
        cogl_color_set_red_byte($!cc, $r);
      }
    );
  }

  method copy {
    cogl_color_copy($!cc);
  }

  method equal (CoglColor() $v2) {
    cogl_color_equal($!cc, $v2);
  }

  method free {
    cogl_color_free($!cc);
  }

  method get_alpha_float is also<get-alpha-float> {
    cogl_color_get_alpha_float($!cc);
  }

  method get_red_float is also<get-red-float> {
    cogl_color_get_alpha_float($!cc);
  }

  method get_green_float is also<get-green-float> {
    cogl_color_get_blue_float($!cc);
  }

  method get_blue_float is also<get-blue-float> {
    cogl_color_get_blue_float($!cc);
  }

  method set_alpha_float (Num() $float) is also<set-alpha-float> {
    my gfloat $f = $float;
    cogl_color_set_alpha_float($!cc, $f);
  }

  method set_red_float (Num() $float) is also<set-red-float> {
    my gfloat $f = $float;
    cogl_color_set_alpha_float($!cc, $f);
  }

  method set_green_float (Num() $float) is also<set-green-float> {
    my gfloat $f = $float;
    cogl_color_set_green_float($!cc, $f);
  }

  method set_blue_float (Num() $float) is also<set-blue-float> {
    my gfloat $f = $float;
    cogl_color_set_blue_float($!cc, $f);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_color_get_gtype, $n, $t );
  }

  method init_from_4f (Num() $red, Num() $green, Num() $blue, Num() $alpha) is also<init-from-4f> {
    my gfloat ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);
    cogl_color_init_from_4f($!cc, $r, $g, $b, $a);
  }

  proto method init_from_4fv (|)
    is also<init-from-4fv>
  { * }

  multi method init_from_4fv(Num @colors) {
    die "COGL::Color.init_from_4fv will only take an array with 4 { ''
         }floating point values."
      unless @colors.elems == 4;

    my $ca = CArray[gfloat].new;
    $ca[$_] = @colors[$_] for @colors;
    samewith($ca);
  }
  multi method init_from_4fv (CArray[gfloat] $color_array) {
    cogl_color_init_from_4fv($!cc, $color_array);
  }

  method init_from_4ub (
    Int() $red,
    Int() $green,
    Int() $blue,
    Int() $alpha
  )
    is also<init-from-4ub>
  {
    my uint8 ($r, $g, $b, $a) = resolve-uint8($red, $green, $blue, $alpha);
    cogl_color_init_from_4ub($!cc, $r, $g, $b, $a);
  }

  method init_from_hsl (Num() $hue, Num() $saturation, Num() $luminance)
    is also<init-from-hsl>
  {
    my gfloat ($h, $s, $l) = ($hue, $saturation, $luminance);
    cogl_color_init_from_hsl($!cc, $h, $s, $l);
  }

  method premultiply {
    cogl_color_premultiply($!cc);
  }

  method set_from_4f (gfloat $red, gfloat $green, gfloat $blue, gfloat $alpha)
    is also<set-from-4f>
  {
    my gfloat ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);
    cogl_color_set_from_4f($!cc, $r, $g, $b, $a);
  }

  method set_from_4ub (
    Int() $red,
    Int() $green,
    Int() $blue,
    Int() $alpha
  )
    is also<set-from-4ub>
  {
    my uint8 ($r, $g, $b, $a) = resolve-uint8($red, $green, $blue, $alpha);
    cogl_color_set_from_4ub($!cc, $r, $g, $b, $a);
  }

  method to_hsl (Num() $hue, Num() $saturation, Num() $luminance)
    is also<to-hsl>
  {
    my gfloat ($h, $s, $l) = ($hue, $saturation, $luminance);
    cogl_color_to_hsl($!cc, $h, $s, $l);
  }

  method unpremultiply {
    cogl_color_unpremultiply($!cc);
  }

}
