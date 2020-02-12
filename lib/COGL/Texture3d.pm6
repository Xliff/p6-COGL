use v6.c;

use Method::Also;
use NativeCall;

use COGL::Raw::Types;
use COGL::Raw::Texture3d;

use COGL::Texture;

our subset Texture3dAncestry is export of Mu
  where CoglTexture3d | TextureAncestry;

class COGL::Texture3d is COGL::Texture {
  has CoglTexture3d $!ct3d;

  submethod BUILD (:$texture3d) {
    given $texture3d {
      when Texture3dAncestry {
        my $to-parent;
        $!ct3d = do {
          when CoglTexture3d {
            $to-parent = cast(CoglTexture, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(CoglTexture3d, $_);
          }
        };
        self.setTexture($to-parent);
      }

      when COGL::Texture3d {
      }

      default {
      }
    }
  }

  method COGL::Raw::Structs::CoglTexture3D
    is also<
      CoglTexture3D
      CoglTexture3d
    >
  { $!ct3d }

  multi method new (CoglTexture3d $texture3d) {
    $texture3d ?? self.bless(:$texture3d) !! Nil;
  }

  multi method new (
    CoglBitmap() $b,
    Int() $height,
    Int() $depth,
    :from_bitmap(:from-bitmap(:$bitmap)) is required
  ) {
    COGL::Texture3d.new_from_bitmap($b, $height, $depth);
  }

  method new_from_bitmap (CoglBitmap() $bitmap, Int() $height, Int() $depth)
    is also<new-from-bitmap>
  {
    my gint ($h, $d) = ($height, $depth);
    my $texture3d = cogl_texture_3d_new_from_bitmap($bitmap, $height, $depth);

    $texture3d ?? self.bless(:$texture3d) !! Nil;
  }

  multi method new (
    CoglContext() $context,
    Int() $width,
    Int() $height,
    Int() $depth,
    Int() $format,
    Int() $rowstride,
    Int() $image_stride,
    CArray[uint8] $d,
    CArray[Pointer[CoglError]] $error = gerror,
    :from_data(:from-data(:$data)) is required
  ) {
    COGL::Texture3d.new_from_data(
      $context,
      $width,
      $height,
      $depth,
      $format,
      $rowstride,
      $image_stride,
      $d,
      $error
    );
  }

  method new_from_data (
    CoglContext() $context,
    Int() $width,
    Int() $height,
    Int() $depth,
    Int() $format,
    Int() $rowstride,
    Int() $image_stride,
    CArray[uint8] $data,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<new-from-data>
  {
    my CoglPixelFormat $f = $format;
    my gint ($w, $h, $d, $r, $i) = (
      $width, $height, $depth, $rowstride, $image_stride);

    clear_error;
    my $texture3d = cogl_texture_3d_new_from_data(
      $context,
      $w,
      $h,
      $d,
      $f,
      $r,
      $i,
      $d,
      $error
    );
    set_error($error);

    $texture3d ?? self.bless(:$texture3d) !! Nil;
  }

  multi method new (
    CoglContext() $context,
    Int() $width,
    Int() $height,
    Int() $depth,
    :with_size(:with-size(:$size)) is required
  ) {
    COGL::Texture3d.new_with_size($context, $width, $height, $depth);
  }
  method new_with_size (
    CoglContext() $context,
    Int() $width,
    Int() $height,
    Int() $depth
  )
    is also<new-with-size>
  {
    my gint ($w, $h, $d) = ($width, $height, $depth);

    my $texture3d = cogl_texture_3d_new_with_size($context, $w, $h, $d);

    $texture3d ?? self.bless(:$texture3d) !! Nil;
  }

  method cogl_is_texture_3d  (
    COGL::Texture3d:U:
    Pointer $candidate
  )
    is also<cogl-is-texture-3d>
  {
    so cogl_is_texture_3d($candidate);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_texture_3d_get_gtype, $n, $t );
  }

}
