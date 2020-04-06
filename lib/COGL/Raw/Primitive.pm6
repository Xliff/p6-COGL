use v6.c;

use NativeCall;


use COGL::Raw::Types;

unit package COGL::Raw::Primatives;

sub cogl_is_primitive (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_primitive_copy (CoglPrimitive $primitive)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_draw (
  CoglPrimitive $primitive,
  CoglFrameBuffer $framebuffer,
  CoglPipeline $pipeline
)
  is native(cogl)
  is export
{ * }

sub cogl_primitive_foreach_attribute (
  CoglPrimitive $primitive,
  &callback (CoglPrimitive, CoglAttribute, gpointer --> CoglBool),
  Pointer $user_data
)
  is native(cogl)
  is export
{ * }

sub cogl_primitive_get_first_vertex (CoglPrimitive $primitive)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_primitive_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_primitive_get_indices (CoglPrimitive $primitive)
  returns CoglIndices
  is native(cogl)
  is export
{ * }

sub cogl_primitive_get_mode (CoglPrimitive $primitive)
  returns guint # CoglVerticesMode
  is native(cogl)
  is export
{ * }

sub cogl_primitive_get_n_vertices (CoglPrimitive $primitive)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_p2 (
  CoglContext $context,
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  Pointer $data # CoglVertexP2 $data
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_p2c4 (
  CoglContext $context,
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  Pointer $data # CoglVertexP2C4 $data
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_p2t2 (
  CoglContext $context,
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  Pointer $data # CoglVertexP2T2 $data
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_p2t2c4 (
  CoglContext $context,
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  Pointer $data # CoglVertexP2T2C4 $data
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_p3 (
  CoglContext $context,
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  Pointer $data # CoglVertexP3 $data
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_p3c4 (
  CoglContext $context,
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  Pointer $data #  CoglVertexP3C4 $data
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_p3t2 (
  CoglContext $context,
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  Pointer $data # CoglVertexP3T2 $data
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_p3t2c4 (
  CoglContext $context,
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  Pointer $data # CoglVertexP3T2C4 $data
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_new_with_attributes (
  guint $mode, # CoglVerticesMode $mode,
  gint $n_vertices,
  CArray[CoglAttribute] $attributes,
  gint $n_attributes
)
  returns CoglPrimitive
  is native(cogl)
  is export
{ * }

sub cogl_primitive_set_attributes (
  CoglPrimitive $primitive,
  CArray[CoglAttribute] $attributes,
  gint $n_attributes
)
  is native(cogl)
  is export
{ * }

sub cogl_primitive_set_first_vertex (
  CoglPrimitive $primitive,
  gint $first_vertex
)
  is native(cogl)
  is export
{ * }

sub cogl_primitive_set_indices (
  CoglPrimitive $primitive,
  Pointer $indices,
  gint $n_indices
)
  is native(cogl)
  is export
{ * }

sub cogl_primitive_set_mode (
  CoglPrimitive $primitive,
  guint $mode, # CoglVerticesMode $mode,
)
  is native(cogl)
  is export
{ * }

sub cogl_primitive_set_n_vertices (CoglPrimitive $primitive, gint $n_vertices)
  is native(cogl)
  is export
{ * }
