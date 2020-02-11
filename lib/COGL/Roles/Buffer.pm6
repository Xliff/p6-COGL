use v6.c;

use NativeCall;

use COGL::Raw::Types;
use COGL::Raw::Buffer;

role COGL::Roles::Buffer {
  has CoglBuffer $!cb;

  method roleInit-Object {
    my \i = findProperImplementor(self.^attributes);

    $!cb = cast(CoglBuffer, i.get_value(self) );
  }

  method update_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglBufferUpdateHintEnum( cogl_buffer_get_update_hint($!cb) );
      },
      STORE => sub ($, Int() $hint is copy) {
        my guint $h = $hint;

        cogl_buffer_set_update_hint($!cb, $h);
      }
    );
  }

  method cogl_is_buffer(gpointer $buf) {
    cogl_is_buffer($buf);
  }

  method get_size {
    cogl_buffer_get_size($!cb);
  }

  method map (Int() $access, Int() $hints) {
    my CoglBufferAccess $a = $access;
    my CoglBufferMapHint $h = $hints;

    cogl_buffer_map($!cb, $a, $h);
  }

  method map_range (
    Int() $offset,
    Int() $size,
    Int() $access,
    Int() $hints,
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    my size_t ($o, $s) = ($offset, $size);
    my CoglBufferAccess $a = $access;
    my CoglBufferMapHint $h = $hints;

    clear_error;
    my $rv = cogl_buffer_map_range($!cb, $o, $s, $a, $h, $error);
    set_error($error);
    $rv;
  }

  method set_data (Int() $offset, gpointer $data, Int() $size) {
    my size_t ($o, $s) = ($offset, $size);

    cogl_buffer_set_data($!cb, $offset, $data, $size);
  }

  method unmap {
    cogl_buffer_unmap($!cb);
  }

}
