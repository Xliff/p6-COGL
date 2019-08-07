use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Buffer;

class COGL::Buffer {
  has CoglBuffer $!cb;
  
  method update_hint is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_buffer_get_update_hint($!cb);
      },
      STORE => sub ($, $hint is copy) {
        cogl_buffer_set_update_hint($!cb, $hint);
      }
    );
  }

  method cogl_is_buffer {
    cogl_is_buffer($!cb);
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

  method set_data (size_t $offset, void $data, size_t $size) {
    cogl_buffer_set_data($!cb, $offset, $data, $size);
  }

  method unmap {
    cogl_buffer_unmap($!cb);
  }
  
}
