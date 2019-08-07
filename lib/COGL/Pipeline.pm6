use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Pipeline;
use COGL::Raw::Pipeline::LayerState;

class COGL::Pipeline {
  has CoglPipeline $!cp;

  method new {
    cogl_pipeline_new();
  }

  method cogl_is_pipeline {
    cogl_is_pipeline($!cp);
  }

  method copy {
    cogl_pipeline_copy($!cp);
  }

  method foreach_layer (
    CoglPipelineLayerCallback $callback,
    gpointer $user_data = gpointer
  ) {
    cogl_pipeline_foreach_layer($!cp, $callback, $user_data);
  }

  method get_gtype {
    cogl_pipeline_get_gtype($!cp);
  }

  method get_uniform_location (Str $uniform_name) {
    cogl_pipeline_get_uniform_location($!cp, $uniform_name);
  }

  method add_layer_snippet (gint $layer, CoglSnippet $snippet) {
    cogl_pipeline_add_layer_snippet($!cp, $layer, $snippet);
  }

  method get_layer_mag_filter (gint $layer_index) {
    cogl_pipeline_get_layer_mag_filter($!cp, $layer_index);
  }

  method get_layer_min_filter (gint $layer_index) {
    cogl_pipeline_get_layer_min_filter($!cp, $layer_index);
  }

  method get_layer_point_sprite_coords_enabled (gint $layer_index) {
    cogl_pipeline_get_layer_point_sprite_coords_enabled($!cp, $layer_index);
  }

  method get_layer_texture (gint $layer_index) {
    cogl_pipeline_get_layer_texture($!cp, $layer_index);
  }

  method get_layer_wrap_mode_p (gint $layer_index) {
    cogl_pipeline_get_layer_wrap_mode_p($!cp, $layer_index);
  }

  method get_layer_wrap_mode_s (gint $layer_index) {
    cogl_pipeline_get_layer_wrap_mode_s($!cp, $layer_index);
  }

  method get_layer_wrap_mode_t (gint $layer_index) {
    cogl_pipeline_get_layer_wrap_mode_t($!cp, $layer_index);
  }

  method get_n_layers () {
    cogl_pipeline_get_n_layers($!cp);
  }

  method remove_layer (gint $layer_index) {
    cogl_pipeline_remove_layer($!cp, $layer_index);
  }

  method set_layer_combine (
    gint $layer_index,
    Str $blend_string,
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    cogl_pipeline_set_layer_combine($!cp, $layer_index, $blend_string, $error);
  }

  method set_layer_combine_constant (gint $layer_index, CoglColor $constant) {
    cogl_pipeline_set_layer_combine_constant($!cp, $layer_index, $constant);
  }

  method set_layer_filters (
    gint $layer_index,
    CoglPipelineFilter $min_filter,
    CoglPipelineFilter $mag_filter
  ) {
    cogl_pipeline_set_layer_filters(
      $!cp, $layer_index, $min_filter, $mag_filter
    );
  }

  method set_layer_matrix (gint $layer_index, CoglMatrix $matrix) {
    cogl_pipeline_set_layer_matrix($!cp, $layer_index, $matrix);
  }

  method set_layer_null_texture (
    gint $layer_index,
    CoglTextureType $texture_type
  ) {
    cogl_pipeline_set_layer_null_texture($!cp, $layer_index, $texture_type);
  }

  method set_layer_point_sprite_coords_enabled (
    gint $layer_index,
    CoglBool $enable,
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    cogl_pipeline_set_layer_point_sprite_coords_enabled(
      $!cp, $layer_index, $enable, $error
    );
  }

  method set_layer_texture (gint $layer_index, CoglTexture $texture) {
    cogl_pipeline_set_layer_texture($!cp, $layer_index, $texture);
  }

  method set_layer_wrap_mode (gint $layer_index, CoglPipelineWrapMode $mode) {
    cogl_pipeline_set_layer_wrap_mode($!cp, $layer_index, $mode);
  }

  method set_layer_wrap_mode_p (
    gint $layer_index,
    CoglPipelineWrapMode $mode
  ) {
    cogl_pipeline_set_layer_wrap_mode_p($!cp, $layer_index, $mode);
  }

  method set_layer_wrap_mode_s (
    gint $layer_index,
    CoglPipelineWrapMode $mode
  ) {
    cogl_pipeline_set_layer_wrap_mode_s($!cp, $layer_index, $mode);
  }

  method set_layer_wrap_mode_t (
    gint $layer_index,
    CoglPipelineWrapMode $mode
  ) {
    cogl_pipeline_set_layer_wrap_mode_t($!cp, $layer_index, $mode);
  }

}
