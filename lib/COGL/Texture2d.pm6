use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Texture2d;

class COGL::Texture2d {
  has CoglTexture2d $!ct2d;
  
  submethod BUILD (:$texture2) {
    $!ct2d = $texture2;
  }

  method new_from_bitmap {
    cogl_texture_2d_new_from_bitmap($!ct2d);
  }

  method new_from_data (
    Int() $width, 
    Int() $height, 
    CoglPixelFormat $format, 
    Int() $rowstride, 
    Pointer $data, 
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    my gint ($w, $h, $rw) = resolve-int($width, $height, $rowstride);
    clear_error;
    my $rc = cogl_texture_2d_new_from_data(
      $!ct2d, 
      $width, 
      $height, 
      $format, 
      $rs, 
      $data, 
      $error
    );
    set_error($error);
    self.bless( texture2 => $rc );
  }

  method new_from_file (
    Str() $filename, 
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    self.bless(
      texture2 => cogl_texture_2d_new_from_file($!ct2d, $filename, $error)
    );
  }

  method new_with_size (Int() $width, Int() $height) {
    my gint ($w, $h) = resolve-int($width, $height);
    self.bless( texture2 => cogl_texture_2d_new_with_size($!ct2d, $w, $h) );
  }
  
  method cogl_is_texture_2d {
    cogl_is_texture_2d($!ct2d);
  }

  method get_gtype {
    state ($n, $t)
    unstable_get_type( self.^name, &cogl_texture_2d_get_gtype, $n, $t );
  }

}
