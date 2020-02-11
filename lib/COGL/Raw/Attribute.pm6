use v6.c;

use NativeCall;


use COGL::Raw::Types;

unit package COGL::Raw::Attribute;

sub cogl_is_attribute (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_attribute_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new (
  CoglAttributeBuffer $attribute_buffer,
  Str $name,
  size_t $stride,
  size_t $offset,
  gint $components,
  uint32 $type # CoglAttributeType $type
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_1f (
  CoglContext $context,
  Str $name,
  gfloat $value
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_2f (
  CoglContext $context,
  Str $name,
  gfloat $component0,
  gfloat $component1
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_2fv (
  CoglContext $context,
  Str $name,
  gfloat $value
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_2x2fv (
  CoglContext $context,
  Str $name,
  gfloat $matrix2x2,
  CoglBool $transpose
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_3f (
  CoglContext $context,
  Str $name,
  gfloat $component0,
  gfloat $component1,
  gfloat $component2
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_3fv (
  CoglContext $context,
  Str $name,
  gfloat $value
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_3x3fv (
  CoglContext $context,
  Str $name,
  gfloat $matrix3x3,
  CoglBool $transpose
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_4f (
  CoglContext $context,
  Str $name,
  gfloat $component0,
  gfloat $component1,
  gfloat $component2,
  gfloat $component3
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_4fv (
  CoglContext $context,
  Str $name,
  gfloat $value
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_new_const_4x4fv (
  CoglContext $context,
  Str $name,
  gfloat $matrix4x4,
  CoglBool $transpose
)
  returns CoglAttribute
  is native(cogl)
  is export
{ * }

sub cogl_attribute_get_buffer (CoglAttribute $attribute)
  returns CoglAttributeBuffer
  is native(cogl)
  is export
{ * }

sub cogl_attribute_get_normalized (CoglAttribute $attribute)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_attribute_set_buffer (
  CoglAttribute $attribute,
  CoglAttributeBuffer $attribute_buffer
)
  is native(cogl)
  is export
{ * }

sub cogl_attribute_set_normalized (
  CoglAttribute $attribute,
  CoglBool $normalized
)
  is native(cogl)
  is export
{ * }
