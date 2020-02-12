use v6.c;

use NativeCall;
use Method::Also;

use COGL::Raw::Types;
use COGL::Raw::Texture2d;

use COGL::Texture;
use COGL::Bitmap;

our subset Texture2dAncestry is export of Mu
  where CoglTexture2d | TextureAncestry;

class COGL::Texture2d { ... }

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

  multi method new (CoglTexture2d $texture2d) {
    $texture2d ?? self.bless(:$texture2d) !! Nil;
  }
  multi method new (COGL::Bitmap $b, :$bitmap is required) {
    COGL::Texture2d.new_from_bitmap( bitmap => $b.CoglBitmap );
  }
  multi method new (CoglBitmap $b, :$bitmap is required) {
    COGL::Texture2d.new_from_bitmap( bitmap => $b );
  }

  method new_from_bitmap (CoglBitmap() $bitmap) is also<new-from-bitmap> {
    my $texture2d = cogl_texture_2d_new_from_bitmap($bitmap);

    $texture2d ?? self.bless(:$texture2d) !! Nil;
  }

  multi method new (
    CoglContext() $context,
    Int() $width,
    Int() $height,
    Int() $format,
    Int() $rowstride,
    CArray[uint8] $d,
    CArray[Pointer[CoglError]] $error = gerror,
    :from_data(:from-data(:$data)) is required
  ) {
    COGL::Texture2d.new_from_data(
      $context,
      $width,
      $height,
      $format,
      $rowstride,
      $d,
      $error
    );
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
    my gint ($w, $h, $rs) = ($width, $height, $rowstride);
    my guint $f = $format;

    clear_error;
    my $texture2d = cogl_texture_2d_new_from_data(
      $context,
      $width,
      $height,
      $f,
      $rs,
      $data,
      $error
    );
    set_error($error);

    $texture2d ?? self.bless(:$texture2d) !! Nil;
  }

  multi method new (
    CoglContext() $context,
    Str() $filename,
    CArray[Pointer[CoglError]] $error = gerror,
    :from_file(:from-file(:$file)) is required
  ) {
    COGL::Texture2d.new_from_file($context, $filename, $error);
  }

  method new_from_file (
    CoglContext() $context,
    Str() $filename,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<new-from-file>
  {
    my $texture2d = cogl_texture_2d_new_from_file($context, $filename, $error);

    $texture2d ?? self.bless(:$texture2d) !! Nil;
  }

  multi method new (
    CoglContext() $context,
    Int() $width,
    Int() $height,
    :with_size(:with-size(:$size)) is required
  ) {
    COGL::Texture2d.new_with_size($context, $width, $height);
  }

  method new_with_size (CoglContext() $context, Int() $width, Int() $height)
    is also<new-with-size>
  {
    my gint ($w, $h) = ($width, $height);
    my $texture2d = cogl_texture_2d_new_with_size($context, $w, $h);
    
    $texture2d ?? self.bless(:$texture2d) !! Nil;
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
