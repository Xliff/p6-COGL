use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;

use COGL::Roles::Buffer;

our subset AttributeBufferAncestry is export of Mu
  where CoglAttributeBuffer | CoglBuffer | CoglObject;

class COGL::AttributeBuffer is COGL::Object {
  also does COGL::Roles::Buffer;
  
  has CoglAttributeBuffer $!cab;
  
  submethod BUILD (:$attribute) {
    given $attribute {
      when AttributeBufferAncestry {
        my $to-parent;
        $!cab = do {
          when CoglAttributeBuffer {
            $to-parent = cast(CoglObject, $_);
            $_;
          }
          
          when CoglBuffer {
            $to-parent = cast(CoglObject, $_);
            $!cb = cast(CoglBuffer, $_);        # COGL::Roles::Buffer
            cast(CoglAttributeBuffer, $_);
          }
          
          default {
            $to-parent = $_;
            cast(CoglAttributeBuffer, $_);
          }
        };
        $!cb //= cast(CoglBuffer, $!cab);       # COGL::Roles::Buffer
        self.setObject($to-parent);
      }
      
      when COGL::AttributeBuffer {
      }
      
      default {
      }
    }
      
  }
  
  method COGL::Raw::Types::CoglAttributeBuffer 
    is also<CoglAttributeBuffer>
  { $!cab }
  
  method new (
    CoglContext() $context, 
    Int() $bytes,
    gpointer $data = gpointer
  ) {
    my uint64 $b = resolve-ulong($b);
    self.bless( attribute => cogl_attribute_buffer_new($context, $b, $data) );
  }

  method new_with_size (
    CoglContext() $context, 
    Int() $bytes
  ) 
    is also<new-with-size> 
  {
    my uint64 $b = resolve-ulong($b);
    self.bless( 
      attribute => cogl_attribute_buffer_new_with_size($context, $b)
    );
  }
  
  method is_attribute_buffer is also<is-attribute-buffer> {
    cogl_is_attribute_buffer($!cab);
  }

  method get_gtype is also<get-gtype> {
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
