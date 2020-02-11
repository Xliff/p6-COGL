use v6.c;

use NativeCall;




use COGL::Raw::Types;
use COGL::Raw::Buffer;

role COGL::Roles::Buffer {
  has CoglBuffer $!cb;

  method update_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglBufferUpdateHint( cogl_buffer_get_update_hint($!cb) );
      },
      STORE => sub ($, Int() $hint is copy) {
        my guint $h = resolve-uint($hint);
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

  method map (CoglBufferAccess $access, CoglBufferMapHint $hints) {
    cogl_buffer_map($!cb, $access, $hints);
  }

  method map_range (
    size_t $offset,
    size_t $size,
    CoglBufferAccess $access,
    CoglBufferMapHint $hints,
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    cogl_buffer_map_range($!cb, $offset, $size, $access, $hints, $error);
  }

  method set_data (size_t $offset, gpointer $data, size_t $size) {
    cogl_buffer_set_data($!cb, $offset, $data, $size);
  }

  method unmap {
    cogl_buffer_unmap($!cb);
  }

}
