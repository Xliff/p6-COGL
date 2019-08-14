use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

use GTK::Raw::Utils;

class COGL::IndexBuffer {
  has CoglIndexBuffer $!cib;
  
  submethod BUILD (:$indexes) {
    $!cib = $indexes;
  }
  
  method new (CoglContext() $context, Int() $bytes) {
    my size_t $b = resolve-long($bytes);
    
    self.bless( indexes => cogl_index_buffer_new($context, $b) );
  }
  
  method is_index_buffer (COGL::IndexBuffer:U: Pointer $candidate) {
    so cogl_is_index_buffer($candidate);
  }

  method get_gtype {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_index_buffer_get_gtype, $n, $t );
  }
}

sub cogl_is_index_buffer (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_index_buffer_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_index_buffer_new (CoglContext $context, size_t $bytes)
  returns CoglIndexBuffer
  is native(cogl)
  is export
{ * }
