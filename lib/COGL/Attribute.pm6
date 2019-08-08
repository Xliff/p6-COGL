use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Attribute;

class COGL::Attribute {
  has CoglAttribute $!ca;

  method new (
    CoglAttributeBuffer() $ab,
    Str() $name,
    size_t $stride,
    size_t $offset,
    gint $components,
    CoglAttributeType $type
  ) {
    cogl_attribute_new($ab, $name, $stride, $offset, $components, $type);
  }

  method new_const_1f (CoglContext() $context, Str() $name, gfloat $value) {
    cogl_attribute_new_const_1f($context, $name, $value);
  }

  method new_const_2f (
    CoglContext() $context,
    Str() $name,
    gfloat $component0,
    gfloat $component1
  ) {
    cogl_attribute_new_const_2f($context, $name, $component0, $component1);
  }

  method new_const_2fv (CoglContext() $context, Str() $name, gfloat $value) {
    cogl_attribute_new_const_2fv($context, $name, $value);
  }

  method new_const_2x2fv (
    CoglContext() $context,
    Str() $name,
    gfloat $matrix2x2,
    CoglBool $transpose
  ) {
    cogl_attribute_new_const_2x2fv($context, $name, $matrix2x2, $transpose);
  }

  method new_const_3f (
    CoglContext() $context,
    Str() $name,
    gfloat $component0,
    gfloat $component1,
    gfloat $component2
  ) {
    cogl_attribute_new_const_3f(
      $context,
      $name,
      $component0,
      $component1,
      $component2
    );
  }

  method new_const_3fv (CoglContext() $context, Str() $name, gfloat $value) {
    cogl_attribute_new_const_3fv($context, $name, $value);
  }

  method new_const_3x3fv (
    CoglContext() $context,
    Str() $name,
    gfloat $matrix3x3,
    CoglBool $transpose
  ) {
    cogl_attribute_new_const_3x3fv($context, $name, $matrix3x3, $transpose);
  }

  method new_const_4f (
    CoglContext() $context,
    Str() $name,
    gfloat $component0,
    gfloat $component1,
    gfloat $component2,
    gfloat $component3
  ) {
    cogl_attribute_new_const_4f(
      $context,
      $name,
      $component0,
      $component1,
      $component2,
      $component3
    );
  }

  method new_const_4fv (CoglContext() $context, Str() $name, gfloat $value) {
    cogl_attribute_new_const_4fv($context, $name, $value);
  }

  method new_const_4x4fv (
    CoglContext() $context,
    Str() $name,
    gfloat $matrix4x4,
    CoglBool $transpose
  ) {
    cogl_attribute_new_const_4x4fv($context, $name, $matrix4x4, $transpose);
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
    cogl_is_attribute($!ca);
  }

  method get_gtype {
    state ($n, $t)
    unstable_get_type( self.^name, &cogl_attribute_get_gtype, $n, $t );
  }

}
