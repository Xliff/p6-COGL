use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Offscreen;

class COGL::Offscreen {
  has CoglOffscreen $!co;
  
  method new_to_texture {
    cogl_offscreen_new_to_texture($!co);
  }

  method new_with_texture {
    cogl_offscreen_new_with_texture($!co);
  }
  
  method cogl_is_offscreen {
    cogl_is_offscreen($!co);
  }

  method get_gtype {
    cogl_offscreen_get_gtype($!co);
  }

  method ref {
    cogl_offscreen_ref($!co);
    self;
  }

  method unref {
    cogl_offscreen_unref($!co);
  }

}
