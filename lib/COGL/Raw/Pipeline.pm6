use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Pipeline;

sub cogl_is_pipeline (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_copy (CoglPipeline $source)
  returns CoglPipeline
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_foreach_layer (
  CoglPipeline $pipeline,
  CoglPipelineLayerCallback $callback,
  Pointer $user_data
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_uniform_location (
  CoglPipeline $pipeline,
  Str $uniform_name
)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_new (CoglContext $context)
  returns CoglPipeline
  is native(cogl)
  is export
{ * }
