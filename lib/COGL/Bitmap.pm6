use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Bitmap;

class COGL::Bitmap {
  has CoglBitmap $!cbm;

  # does COGL::Object?
  submethod BUILD (:$bitmap) {
    $!cbm = $bitmap;
  }

  method new_for_data (
    Int() $width,
    Int() $height,
    Int() $format,
    Int() $rowstride,
    CArray[uint8] $data
  ) {
    my gint ($w, $h, $r) = ($width, $height, $rowstride);
    my guint $f = resolve-uint($format);
    self.bless(
      bitmap => cogl_bitmap_new_for_data($!cbm, $w, $h, $f, $r, $data)
    );
  }

  method new_from_buffer (
    Int() $format,
    Int() $width,
    Int() $height,
    Int() $rowstride,
    Int() $offset
  ) {
    my gint ($w, $h, $r, $o) = ($width, $height, $rowstride, $offset);
    my guint $f = resolve-uint($format);
    self.bless(
      bitmap => cogl_bitmap_new_from_buffer($!cbm, $f, $w, $h, $r, $o)
    );
  }

  method new_from_file (
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    clear_error;
    my $rc = cogl_bitmap_new_from_file($!cbm, $error);
    set_error($error);
    self.bless( bitmap => $rc );
  }

  method is_bitmap {
    so cogl_is_bitmap($!cbm);
  }

  method error_quark {
    cogl_bitmap_error_quark();
  }

  # COGL::PixelBuffer does COGL::Buffer?
  method get_buffer {
    cogl_bitmap_get_buffer($!cbm);
  }

  method get_format {
    CoglPixelFormat( cogl_bitmap_get_format($!cbm) );
  }

  method get_gtype {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_bitmap_get_gtype, $n, $t );
  }

  method get_height {
    cogl_bitmap_get_height($!cbm);
  }

  method get_rowstride {
    cogl_bitmap_get_rowstride($!cbm);
  }

  method get_size_from_file (Int() $width, Int() $height) {
    my gint ($w, $h) = resolve-int($width, $height);
    cogl_bitmap_get_size_from_file($!cbm, $w, $h);
  }

  method get_width {
    cogl_bitmap_get_width($!cbm);
  }

}
