use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

class COGL::AttributeBuffer {
  has CoglAttributeBuffer $!cab;
  
  method new (CoglContext $context, size_t $bytes, Pointer $data) {
    cogl_attribute_buffer_new($context, $bytes, $data);
  }

  method new_with_size (CoglContext $context, size_t $bytes) {
    cogl_attribute_buffer_new_with_size($context, $bytes);
  }
  
  method cogl_is_attribute_buffer {
    cogl_is_attribute_buffer($!cab);
  }

  method get_gtype {
    cogl_attribute_buffer_get_gtype();
  }

}

sub cogl_is_attribute_buffer (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_attribute_buffer_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_attribute_buffer_new (
  CoglContext $context, 
  size_t $bytes, 
  Pointer $data
)
  returns CoglAttributeBuffer
  is native(cogl)
  is export
{ * }

sub cogl_attribute_buffer_new_with_size (CoglContext $context, size_t $bytes)
  returns CoglAttributeBuffer
  is native(cogl)
  is export
{ * }
