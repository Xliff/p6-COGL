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


# PIPELINE STATE

sub cogl_pipeline_add_snippet (CoglPipeline $pipeline, CoglSnippet $snippet)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_alpha_test_function (CoglPipeline $pipeline)
  returns guint # CoglPipelineAlphaFunc
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_alpha_test_reference (CoglPipeline $pipeline)
  returns gfloat
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_ambient (CoglPipeline $pipeline, CoglColor $ambient)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_color (CoglPipeline $pipeline, CoglColor $color)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_depth_state (
  CoglPipeline $pipeline,
  CoglDepthState $state_out
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_diffuse (CoglPipeline $pipeline, CoglColor $diffuse)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_emission (CoglPipeline $pipeline, CoglColor $emission)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_per_vertex_point_size (CoglPipeline $pipeline)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_specular (CoglPipeline $pipeline, CoglColor $specular)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_alpha_test_function (
  CoglPipeline $pipeline,
  guint $alpha_func, # CoglPipelineAlphaFunc $alpha_func,
  gfloat $alpha_reference
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_ambient (CoglPipeline $pipeline, CoglColor $ambient)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_ambient_and_diffuse (
  CoglPipeline $pipeline,
  CoglColor $color
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_blend (
  CoglPipeline $pipeline,
  Str $blend_string,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_blend_constant (
  CoglPipeline $pipeline,
  CoglColor $constant_color
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_color (CoglPipeline $pipeline, CoglColor $color)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_color4f (
  CoglPipeline $pipeline,
  gfloat $red,
  gfloat $green,
  gfloat $blue,
  gfloat $alpha
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_color4ub (
  CoglPipeline $pipeline,
  uint8 $red,
  uint8 $green,
  uint8 $blue,
  uint8 $alpha
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_depth_state (
  CoglPipeline $pipeline,
  guint $state, # CoglDepthState $state,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_diffuse (CoglPipeline $pipeline, CoglColor $diffuse)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_emission (CoglPipeline $pipeline, CoglColor $emission)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_per_vertex_point_size (
  CoglPipeline $pipeline,
  CoglBool $enable,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_specular (CoglPipeline $pipeline, CoglColor $specular)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_uniform_1f (
  CoglPipeline $pipeline,
  gint $uniform_location,
  gfloat $value
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_uniform_1i (
  CoglPipeline $pipeline,
  gint $uniform_location,
  gint $value
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_uniform_float (
  CoglPipeline $pipeline,
  gint $uniform_location,
  gint $n_components,
  gint $count,
  CArray[gfloat] $value
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_uniform_int (
  CoglPipeline $pipeline,
  gint $uniform_location,
  gint $n_components,
  gint $count,
  CArray[gint] $value
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_uniform_matrix (
  CoglPipeline $pipeline,
  gint $uniform_location,
  gint $dimensions,
  gint $count,
  CoglBool $transpose,
  CArray[gfloat] $value
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_color_mask (CoglPipeline $pipeline)
  returns guint # CoglColorMask
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_cull_face_mode (CoglPipeline $pipeline)
  returns guint # CoglPipelineCullFaceMode
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_front_face_winding (CoglPipeline $pipeline)
  returns guint # CoglWinding
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_point_size (CoglPipeline $pipeline)
  returns gfloat
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_shininess (CoglPipeline $pipeline)
  returns gfloat
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_get_user_program (CoglPipeline $pipeline)
  returns CoglHandle
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_color_mask (
  CoglPipeline $pipeline,
  guint $color_mask # CoglColorMask $color_mask
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_cull_face_mode (
  CoglPipeline $pipeline,
  guint $cull_face_mode # CoglPipelineCullFaceMode $cull_face_mode
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_front_face_winding (
  CoglPipeline $pipeline,
  guint $front_winding # CoglWinding $front_winding
)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_point_size (CoglPipeline $pipeline, gfloat $point_size)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_shininess (CoglPipeline $pipeline, gfloat $shininess)
  is native(cogl)
  is export
{ * }

sub cogl_pipeline_set_user_program (
  CoglPipeline $pipeline,
  CoglHandle $program
)
  is native(cogl)
  is export
{ * }
