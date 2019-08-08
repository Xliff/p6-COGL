use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;

use COGL::Roles::Buffer;

class COGL::AttributeBuffer {
  also does COGL::Roles::Buffer;
  
  has CoglAttributeBuffer $!cab;
  
  submethod BUILD (:$attribute) {
    $!cb = cast(CoglBuffer, $!cab = $attribute);  # COGL::Roles::Buffer
  }
  
  method new (
    CoglContext() $context, 
    Int() $bytes,
    gpointer $data = gpointer
  ) {
    my gulong $b = resolve-ulong($b);
    self.bless( attribute => cogl_attribute_buffer_new($context, $b, $data) );
  }

  method new_with_size (
    CoglContext() $context, 
    Int() $bytes
  ) {
    my gulong $b = resolve-ulong($b);
    self.bless( 
      attribute => cogl_attribute_buffer_new_with_size($context, $b)
    );
  }
  
  method cogl_is_attribute_buffer {
    cogl_is_attribute_buffer($!cab);
  }

  method get_gtype {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_attribute_buffer_get_gtype, $n, $t );
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
