use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Indices;

sub cogl_get_rectangle_indices (CoglContext $context, gint $n_rectangles)
  returns CoglIndices
  is native(cogl)
  is export
{ * }

sub cogl_is_indices (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_indices_get_buffer (CoglIndices $indices)
  returns CoglIndexBuffer
  is native(cogl)
  is export
{ * }

sub cogl_indices_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_indices_get_type (CoglIndices $indices)
  returns guint # CoglIndicesType
  is native(cogl)
  is export
{ * }

sub cogl_indices_new (
  CoglContext $context, 
  guint $type, # CoglIndicesType $type, 
  Pointer $indices_data, 
  gint $n_indices
)
  returns CoglIndices
  is native(cogl)
  is export
{ * }

sub cogl_indices_new_for_buffer (
  guint $type, # CoglIndicesType $type, 
  CoglIndexBuffer $buffer, 
  size_t $offset
)
  returns CoglIndices
  is native(cogl)
  is export
{ * }

sub cogl_indices_get_offset (CoglIndices $indices)
  returns size_t
  is native(cogl)
  is export
{ * }

sub cogl_indices_set_offset (CoglIndices $indices, size_t $offset)
  is native(cogl)
  is export
{ * }
