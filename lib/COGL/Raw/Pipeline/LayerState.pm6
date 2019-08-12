use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Pipeline::LayerState;

sub cogl_pipeline_add_layer_snippet (
  CoglPipeline $pipeline,
  gint $layer,
  CoglSnippet $snippet
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_layer_mag_filter (
  CoglPipeline $pipeline,
  gint $layer_index
)
  returns guint # CoglPipelineFilter
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_layer_min_filter (
  CoglPipeline $pipeline,
  gint $layer_index
)
  returns guint # CoglPipelineFilter
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_layer_point_sprite_coords_enabled (
  CoglPipeline $pipeline,
  gint $layer_index
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_layer_texture (
  CoglPipeline $pipeline,
  gint $layer_index
)
  returns CoglTexture
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_layer_wrap_mode_p (
  CoglPipeline $pipeline,
  gint $layer_index
)
  returns guint # CoglPipelineWrapMode
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_layer_wrap_mode_s (
  CoglPipeline $pipeline,
  gint $layer_index
)
  returns guint # CoglPipelineWrapMode
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_layer_wrap_mode_t (
  CoglPipeline $pipeline,
  gint $layer_index
)
  returns guint # CoglPipelineWrapMode
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_n_layers (CoglPipeline $pipeline)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_remove_layer (CoglPipeline $pipeline, gint $layer_index)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_combine (
  CoglPipeline $pipeline,
  gint $layer_index,
  Str $blend_string,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_combine_constant (
  CoglPipeline $pipeline,
  gint $layer_index,
  CoglColor $constant
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_filters (
  CoglPipeline $pipeline,
  gint $layer_index,
  guint $min_filter,  # CoglPipelineFilter
  guint $mag_filter   # CoglPipelineFilter
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_matrix (
  CoglPipeline $pipeline,
  gint $layer_index,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_null_texture (
  CoglPipeline $pipeline,
  gint $layer_index,
  guint $texture_type # CoglTextureType $texture_type
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_point_sprite_coords_enabled (
  CoglPipeline $pipeline,
  gint $layer_index,
  CoglBool $enable,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_texture (
  CoglPipeline $pipeline,
  gint $layer_index,
  CoglTexture $texture
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_wrap_mode (
  CoglPipeline $pipeline,
  gint $layer_index,
  guint $mode # CoglPipelineWrapMode $mode
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_wrap_mode_p (
  CoglPipeline $pipeline,
  gint $layer_index,
  guint $mode # CoglPipelineWrapMode $mode
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_wrap_mode_s (
  CoglPipeline $pipeline,
  gint $layer_index,
  guint $mode # CoglPipelineWrapMode $mode
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_layer_wrap_mode_t (
  CoglPipeline $pipeline,
  gint $layer_index,
  guint $mode # CoglPipelineWrapMode $mode
)
  is native(cogl)
  is export
{ * }
