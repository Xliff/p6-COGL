use v6.c;

use Method::Also;
use NativeCall;




use COGL::Raw::Types;
use COGL::Raw::Texture;

use COGL::Object;

our subset TextureAncestry is export of Mu
  where CoglTexture | CoglObject;

class COGL::Texture is COGL::Object {
  has CoglTexture $!ct;

  method setTexture (TextureAncestry $_) {
    my $to-parent;
    $!ct = do {
      when CoglTexture {
        $to-parent = cast(CoglObject, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(CoglTexture, $_);
      }
    }
    self.setObject($to-parent);
  }

  method COGL::Raw::Definitions::CoglTexture
    is also<CoglTexture>
  { $!ct }


  method components is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglTextureComponents( cogl_texture_get_components($!ct) );
      },
      STORE => sub ($, Int() $components is copy) {
        my guint $c = resolve-uint($components);
        cogl_texture_set_components($!ct, $c);
      }
    );
  }

  method premultiplied is rw {
    Proxy.new(
      FETCH => sub ($) {
        so cogl_texture_get_premultiplied($!ct);
      },
      STORE => sub ($, Int() $premultiplied is copy) {
        my gboolean $p = resolve-bool($premultiplied);
        cogl_texture_set_premultiplied($!ct, $p);
      }
    );
  }

  method allocate (CArray[Pointer[CoglError]] $error = gerror) {
    cogl_texture_allocate($!ct, $error);
  }

  method is_texture (COGL::Texture:U: gpointer $candidate)
    is also<is-texture>
  {
    so cogl_is_texture($candidate);
  }

  method error_quark is also<error-quark> {
    cogl_texture_error_quark();
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_texture_get_gtype, $n, $t );
  }

  method get_height is also<get-height> {
    cogl_texture_get_height($!ct);
  }

  method get_max_waste is also<get-max-waste> {
    cogl_texture_get_max_waste($!ct);
  }

  method get_width is also<get-width> {
    cogl_texture_get_width($!ct);
  }

  method is_sliced is also<is-sliced> {
    so cogl_texture_is_sliced($!ct);
  }

  method set_data (
    Int() $format,
    Int() $rowstride,
    CArray[uint8] $data,
    Int() $level,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<set-data>
  {
    my guint $f = resolve-uint($format);
    my gint ($r, $l) = resolve-int($rowstride, $level);

    clear_error;
    my $rc = cogl_texture_set_data($!ct, $f, $r, $data, $l, $error);
    set_error($error);
    so $rc;
  }

}
