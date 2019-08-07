use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Texture;

class COGL::Texture {
  has CoglTexture $!ct;
  
  method components is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_texture_get_components($!ct);
      },
      STORE => sub ($, $components is copy) {
        cogl_texture_set_components($!ct, $components);
      }
    );
  }

  method premultiplied is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_texture_get_premultiplied($!ct);
      },
      STORE => sub ($, $premultiplied is copy) {
        cogl_texture_set_premultiplied($!ct, $premultiplied);
      }
    );
  }

  method allocate (CArray[Pointer[CoglError]] $error = gerror) {
    cogl_texture_allocate($!ct, $error);
  }

  method cogl_is_texture {
    cogl_is_texture($!ct);
  }

  method error_quark {
    cogl_texture_error_quark($!ct);
  }

  method get_gtype {
    cogl_texture_get_gtype($!ct);
  }

  method get_height {
    cogl_texture_get_height($!ct);
  }

  method get_max_waste {
    cogl_texture_get_max_waste($!ct);
  }

  method get_width {
    cogl_texture_get_width($!ct);
  }

  method is_sliced {
    cogl_texture_is_sliced($!ct);
  }

  method set_data (
    CoglPixelFormat $format, 
    gint $rowstride, 
    uint8_t $data, 
    gint $level, 
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    cogl_texture_set_data($!ct, $format, $rowstride, $data, $level, $error);
  }

}
