use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Attribute;

use COGL::Object;

our subset AttributeAncestry is export of Mu
  where CoglAttribute | CoglObject

class COGL::Attribute is COGL::Object {
  has CoglAttribute $!ca;
  
  submethod BUILD (:$attribute) {
    given $attribute {
      when AttributeAncestry {
        my $to-parent;
        $!ca = do {
          when CoglAttribute {
            $to-parent = cast(CoglObject, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(CoglAttribute, $_);
          }
        }
        self.setObject($to-parent);
      }
      
      when COGL::Attribute {
      }
      
      default {
      }
    }
  }

  method new (
    CoglAttributeBuffer() $ab,
    Str() $name,
    size_t $stride,
    size_t $offset,
    gint $components,
    CoglAttributeType $type
  ) {
    self.bless(
      attribute => cogl_attribute_new(
        $ab, $name, $stride, $offset, $components, $type
      )
    );
  }

  method new_const_1f (CoglContext() $context, Str() $name, Num() $value) {
    my gfloat $v = $value;
    
    self.bless( 
      attribute => cogl_attribute_new_const_1f($context, $name, $v)
    );
  }

  method new_const_2f (
    CoglContext() $context,
    Str() $name,
    Num() $component0,
    Num() $component1
  ) {
    my gfloat ($c0, $c1) = ($component0, $component1);
    
    self.bless(
      attribute =>cogl_attribute_new_const_2f($context, $name, $c0, $c1)
    );
  }

  method new_const_2fv (CoglContext() $context, Str() $name, gfloat $value) {
    self.bless(
      attribute => cogl_attribute_new_const_2fv($context, $name, $value)
    );
  }

  method new_const_2x2fv (
    CoglContext() $context,
    Str() $name,
    CArray[gfloat] $matrix2x2,
    Int() $transpose
  ) {
    my gboolean $t = resolve-bool($transpose);
    
    self.bless(
      attribute => cogl_attribute_new_const_2x2fv(
        $context, $name, $matrix2x2, $transpose
      )
    );
  }

  method new_const_3f (
    CoglContext() $context,
    Str() $name,
    Num() $component0,
    Num() $component1,
    Num() $component2
  ) {
    my gfloat ($c0, $c1, $c2) = ($component0, $component1, $component2);
    
    self.bless(
      attribute => cogl_attribute_new_const_3f($context, $name, $c0, $c1, $c2)
    );
  }

  method new_const_3fv (CoglContext() $context, Str() $name, Num() $value) {
    my gfloat $v = $value;
    
    self.bless(
      attribute => cogl_attribute_new_const_3fv($context, $name, $v)
    );
  }

  method new_const_3x3fv (
    CoglContext() $context,
    Str() $name,
    CArray[gfloat] $matrix3x3,
    Int() $transpose
  ) {
    my gboolean $t = resolve-bool($transpose);
    
    self.bless(
      attribute => cogl_attribute_new_const_3x3fv(
        $context, $name, $matrix3x3, $t
      )
    );
  }

  method new_const_4f (
    CoglContext() $context,
    Str() $name,
    Num() $component0,
    Num() $component1,
    Num() $component2,
    Num() $component3
  ) {
    my gfloat ($c0, $c1, $c2, $c3) = 
      ($component0, $component1, $component2, $component3);
      
    self.bless(
      attribute => cogl_attribute_new_const_4f(
        $context, $name, $c0, $c1, $c2, $c3
      )
    );
  }

  method new_const_4fv (CoglContext() $context, Str() $name, Num() $value) {
    my gfloat $v = $value;
    
    self.bless( 
      attribute =>cogl_attribute_new_const_4fv($context, $name, $v)
    );
  }

  method new_const_4x4fv (
    CoglContext() $context,
    Str() $name,
    CArray[gfloat] $matrix4x4,
    Int() $transpose
  ) {
    my gboolean $t = resolve-bool($transpose);
    
    self.bless( 
      attribute => cogl_attribute_new_const_4x4fv(
        $context, $name, $matrix4x4, $t
      )
    );  
  }

  method buffer is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_attribute_get_buffer($!ca);
      },
      STORE => sub ($, $attribute_buffer is copy) {
        cogl_attribute_set_buffer($!ca, $attribute_buffer);
      }
    );
  }

  method normalized is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_attribute_get_normalized($!ca);
      },
      STORE => sub ($, $normalized is copy) {
        cogl_attribute_set_normalized($!ca, $normalized);
      }
    );
  }

  method cogl_is_attribute {
    so cogl_is_attribute($!ca);
  }

  method get_gtype {
    state ($n, $t)
    unstable_get_type( self.^name, &cogl_attribute_get_gtype, $n, $t );
  }

}
