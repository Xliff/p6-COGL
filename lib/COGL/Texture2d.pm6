use v6.c;

use NativeCall;
use Method::Also;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Texture2d;

use COGL::Texture;

our subset Texture2dAncestry is export of Mu
  where CoglTexture2d | TextureAncestry;

class COGL::Texture2d is COGL::Texture {
  has CoglTexture2d $!ct2d;

  submethod BUILD (:$texture2d) {
    given $texture2d {
      when Texture2dAncestry {
        my $to-parent;
        $!ct2d = do {
          when CoglTexture2d {
            $to-parent = cast(CoglTexture, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(CoglTexture2d, $_);
          }
        };
        self.setTexture($to-parent);
      }

      when COGL::Texture2d {
      }

      default {
      }
    }
  }

  method new_from_bitmap (CoglBitmap() $bitmap) is also<new-from-bitmap> {
    self.bless( texture2d => cogl_texture_2d_new_from_bitmap($bitmap) );
  }

  method new_from_data (
    CoglContext() $context,
    Int() $width,
    Int() $height,
    Int() $format,
    Int() $rowstride,
    CArray[uint8] $data,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<new-from-data>
  {
    my gint ($w, $h, $rs) = resolve-int($width, $height, $rowstride);
    my guint $f = resolve-uint($format);

    clear_error;
    my $rc = cogl_texture_2d_new_from_data(
      $context,
      $width,
      $height,
      $f,
      $rs,
      $data,
      $error
    );
    set_error($error);
    self.bless( texture2d => $rc );
  }

  method new_from_file (
    CoglContext() $context,
    Str() $filename,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<new-from-file>
  {
    self.bless(
      texture2d => cogl_texture_2d_new_from_file($context, $filename, $error)
    );
  }

  method new_with_size (CoglContext() $context, Int() $width, Int() $height)
    is also<new-with-size>
  {
    my gint ($w, $h) = resolve-int($width, $height);

    self.bless( texture2d => cogl_texture_2d_new_with_size($context, $w, $h) );
  }

  method is_texture_2d (COGL::Texture2d:U: gpointer $candidate)
    is also<is-texture-2d>
  {
    so cogl_is_texture_2d($candidate);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_texture_2d_get_gtype, $n, $t );
  }

}
