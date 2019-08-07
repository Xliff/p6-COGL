use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Color;

class COGL::Color {
  has CoglColor $!cc;
  
  method new {
    cogl_color_new();
  }
  
  method alpha is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_alpha($!cc);
      },
      STORE => sub ($, $alpha is copy) {
        cogl_color_set_alpha($!cc, $alpha);
      }
    );
  }

  method alpha_byte is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_alpha_byte($!cc);
      },
      STORE => sub ($, $alpha is copy) {
        cogl_color_set_alpha_byte($!cc, $alpha);
      }
    );
  }

  method blue is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_blue($!cc);
      },
      STORE => sub ($, $blue is copy) {
        cogl_color_set_blue($!cc, $blue);
      }
    );
  }

  method blue_byte is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_blue_byte($!cc);
      },
      STORE => sub ($, $blue is copy) {
        cogl_color_set_blue_byte($!cc, $blue);
      }
    );
  }

  method green is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_green($!cc);
      },
      STORE => sub ($, $green is copy) {
        cogl_color_set_green($!cc, $green);
      }
    );
  }

  method green_byte is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_green_byte($!cc);
      },
      STORE => sub ($, $green is copy) {
        cogl_color_set_green_byte($!cc, $green);
      }
    );
  }

  method red is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_red($!cc);
      },
      STORE => sub ($, $red is copy) {
        cogl_color_set_red($!cc, $red);
      }
    );
  }

  method red_byte is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_color_get_red_byte($!cc);
      },
      STORE => sub ($, $red is copy) {
        cogl_color_set_red_byte($!cc, $red);
      }
    );
  }
  
  method copy {
    cogl_color_copy($!cc);
  }

  method equal (void $v2) {
    cogl_color_equal($!cc, $v2);
  }

  method free {
    cogl_color_free($!cc);
  }

  method get_alpha_float {
    cogl_color_get_alpha_float($!cc);
  }
  
  method get_red_float {
    cogl_color_get_alpha_float($!cc);
  }
  
  method get_green_float {
    cogl_color_get_blue_float($!cc);
  }

  method get_blue_float {
    cogl_color_get_blue_float($!cc);
  }
  
  method set_alpha_float (gfloat $f) {
    cogl_color_get_alpha_float($!cc, $f);
  }
  
  method set_red_float (gfloat $f) {
    cogl_color_get_alpha_float($!cc, $f);
  }
  
  method set_green_float (gfloat $f) {
    cogl_color_get_green_float($!cc, $f);
  }

  method set_blue_float (gfloat $f) {
    cogl_color_get_blue_float($!cc, $f);
  }

  method get_gtype {
    cogl_color_get_gtype($!cc);
  }

  method init_from_4f (gfloat $red, gfloat $green, gfloat $blue, gfloat $alpha) {
    cogl_color_init_from_4f($!cc, $red, $green, $blue, $alpha);
  }

  method init_from_4fv (gfloat $color_array) {
    cogl_color_init_from_4fv($!cc, $color_array);
  }

  method init_from_4ub (uint8_t $red, uint8_t $green, uint8_t $blue, uint8_t $alpha) {
    cogl_color_init_from_4ub($!cc, $red, $green, $blue, $alpha);
  }

  method init_from_hsl (gfloat $hue, gfloat $saturation, gfloat $luminance) {
    cogl_color_init_from_hsl($!cc, $hue, $saturation, $luminance);
  }

  method premultiply {
    cogl_color_premultiply($!cc);
  }

  method set_from_4f (gfloat $red, gfloat $green, gfloat $blue, gfloat $alpha) {
    cogl_color_set_from_4f($!cc, $red, $green, $blue, $alpha);
  }

  method set_from_4ub (uint8_t $red, uint8_t $green, uint8_t $blue, uint8_t $alpha) {
    cogl_color_set_from_4ub($!cc, $red, $green, $blue, $alpha);
  }

  method to_hsl (gfloat $hue, gfloat $saturation, gfloat $luminance) {
    cogl_color_to_hsl($!cc, $hue, $saturation, $luminance);
  }

  method unpremultiply {
    cogl_color_unpremultiply($!cc);
  }

}
