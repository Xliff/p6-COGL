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
    self.setCoglObject($to-parent);
  }

  method COGL::Raw::Definitions::CoglTexture
    is also<CoglTexture>
  { $!ct }

  method components is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglTextureComponentsEnum( cogl_texture_get_components($!ct) );
      },
      STORE => sub ($, Int() $components is copy) {
        my guint $c = $components;

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
        my gboolean $p = $premultiplied.so.Int;

        cogl_texture_set_premultiplied($!ct, $p);
      }
    );
  }

  method allocate (CArray[Pointer[CoglError]] $error = gerror) {
    clear_error;
    my $rv = so cogl_texture_allocate($!ct, $error);
    set_error($error);
    $rv;
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
    my guint $f = $format;
    my gint ($r, $l) = ($rowstride, $level);

    clear_error;
    my $rc = cogl_texture_set_data($!ct, $f, $r, $data, $l, $error);
    set_error($error);
    so $rc;
  }

  method set_region (
    Int() $src_x,
    Int() $src_y,
    Int() $dst_x,
    Int() $dst_y,
    Int() $dst_width,
    Int() $dst_height,
    Int() $width,
    Int() $height,
    Int() $format,
    Int() $rowstride,
    CArray[uint8] $data
  )
    is also<set-region>
  {
    my gint ($sx, $sy, $dx, $dy, $w, $h) =
      ($src_x, $src_y, $dst_x, $dst_y, $width, $height);
    my guint ($dw, $dh, $r) = ($dst_width, $dst_height, $rowstride);
    my CoglPixelFormat $f = $format;

    so cogl_texture_set_region(
      $!ct,
      $sx,
      $sy,
      $dx,
      $dy,
      $dw,
      $dh,
      $w,
      $h,
      $f,
      $r,
      $data
    );
  }

}
