use v6.c;

use NativeCall;
use Method::Also;

use COGL::Raw::Types;
use COGL::Raw::Attribute;

use COGL::Object;
use COGL::AttributeBuffer;

our subset AttributeAncestry is export of Mu
  where CoglAttribute | CoglObject;

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

  method COGL::Raw::Types::CoglAttribute
    is also<CoglAttribute>
  { $!ca }

  method new (
    CoglAttributeBuffer() $ab,
    Str() $name,
    Int() $stride,
    Int() $offset,
    Int() $components,
    Int() $type
  ) {
    my uint64 ($s, $o) = ($stride, $offset);
    my gint $c = $components;
    my guint $t = $type;
    my $attribute = cogl_attribute_new($ab, $name, $s, $o, $c, $t);

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_1f (CoglContext() $context, Str() $name, Num() $value)
    is also<new-const-1f>
  {
    my gfloat $v = $value;
    my $attribute = cogl_attribute_new_const_1f($context, $name, $v);

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_2f (
    CoglContext() $context,
    Str() $name,
    Num() $component0,
    Num() $component1
  )
    is also<new-const-2f>
  {
    my gfloat ($c0, $c1) = ($component0, $component1);
    my $attribute = cogl_attribute_new_const_2f($context, $name, $c0, $c1);

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_2fv (CoglContext() $context, Str() $name, gfloat $value)
    is also<new-const-2fv>
  {
    my $attribute = cogl_attribute_new_const_2fv($context, $name, $value);

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_2x2fv (
    CoglContext() $context,
    Str() $name,
    CArray[gfloat] $matrix2x2,
    Int() $transpose
  )
    is also<new-const-2x2fv>
  {
    my gboolean $t = $transpose.so.Int;
    my $attribute = cogl_attribute_new_const_2x2fv(
      $context,
      $name,
      $matrix2x2,
      $transpose
    );

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_3f (
    CoglContext() $context,
    Str() $name,
    Num() $component0,
    Num() $component1,
    Num() $component2
  )
    is also<new-const-3f>
  {
    my gfloat ($c0, $c1, $c2) = ($component0, $component1, $component2);
    my $attribute => cogl_attribute_new_const_3f(
      $context,
      $name,
      $c0,
      $c1,
      $c2
    );

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_3fv (CoglContext() $context, Str() $name, Num() $value)
    is also<new-const-3fv>
  {
    my gfloat $v = $value;
    my $attribute = cogl_attribute_new_const_3fv($context, $name, $v);

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_3x3fv (
    CoglContext() $context,
    Str() $name,
    CArray[gfloat] $matrix3x3,
    Int() $transpose
  )
    is also<new-const-3x3fv>
  {
    my gboolean $t = $transpose.so.Int;
    my $attribute = cogl_attribute_new_const_3x3fv(
      $context,
      $name,
      $matrix3x3,
      $t
    );

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_4f (
    CoglContext() $context,
    Str() $name,
    Num() $component0,
    Num() $component1,
    Num() $component2,
    Num() $component3
  )
    is also<new-const-4f>
  {
    my gfloat ($c0, $c1, $c2, $c3) =
      ($component0, $component1, $component2, $component3);

    self.bless(
      attribute => cogl_attribute_new_const_4f(
        $context, $name, $c0, $c1, $c2, $c3
      )
    );
    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_4fv (CoglContext() $context, Str() $name, Num() $value)
    is also<new-const-4fv>
  {
    my gfloat $v = $value;
    my $attribute = cogl_attribute_new_const_4fv($context, $name, $v);

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method new_const_4x4fv (
    CoglContext() $context,
    Str() $name,
    CArray[gfloat] $matrix4x4,
    Int() $transpose
  )
    is also<new-const-4x4fv>
  {
    my gboolean $t = $transpose.so.Int;
    my attribute = cogl_attribute_new_const_4x4fv(
      $context,
      $name,
      $matrix4x4,
      $t
    );

    $attribute ?? self.bless(:$attribute) !! Nil;
  }

  method buffer(:$raw = False) is rw {
    Proxy.new(
      FETCH => sub ($) {
        my $b = cogl_attribute_get_buffer($!ca);

        $b.defined ??
          ( $raw ?? $b !! COGL::AttributeBuffer.new($b) )
          !!
          Nil;
      },
      STORE => sub ($, CoglAttributeBuffer() $attribute_buffer is copy) {
        cogl_attribute_set_buffer($!ca, $attribute_buffer);
      }
    );
  }

  method normalized is rw {
    Proxy.new(
      FETCH => sub ($) {
        so cogl_attribute_get_normalized($!ca);
      },
      STORE => sub ($, Int() $normalized is copy) {
        my guint $n = $normalized.so.Int;

        cogl_attribute_set_normalized($!ca, $n);
      }
    );
  }

  method cogl_is_attribute (COGL::Attribute:U: gpointer $candidate)
    is also<cogl-is-attribute>
  {
    so cogl_is_attribute($candidate);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_attribute_get_gtype, $n, $t );
  }

}
