use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Pipeline;
use COGL::Raw::Pipeline::LayerState;

use COGL::Object;

our subset PipelineAncestry is export of Mu
  where CoglPipeline | CoglObject;

class COGL::Pipeline is COGL::Object {
  has CoglPipeline $!cp;

  submethod BUILD (:$pipeline) {
    when PipelineAncestry {
      my $to-parent;
      $!cp = do {
        when CoglPipeline {
          $to-parent = cast(CoglObject, $_);
          $_;
        }

        default {
          $to-parent = $_;
          cast(CoglPipeline, $_);
        }
      }
      self.setObject($to-parent);
    }

    when COGL::Pipeline {
    }

    default {
    }
  }

  method COGL::Raw::Types::CoglPipeline
    is also<CoglPipeline>
  { $!cp }

  method new (CoglContext() $context) {
    self.bless( pipeline => cogl_pipeline_new($context) );
  }

  method is_pipeline (COGL::Pipeline:U: gpointer $candidate)
    is also<is-pipeline>
  {
    so cogl_is_pipeline($candidate);
  }

  method copy {
    self.bless( pipeline => cogl_pipeline_copy($!cp) );
  }

  method foreach_layer (
    CoglPipelineLayerCallback $callback,
    gpointer $user_data = gpointer
  )
    is also<foreach-layer>
  {
    cogl_pipeline_foreach_layer($!cp, $callback, $user_data);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_pipeline_get_gtype, $n, $t );
  }

  method get_uniform_location (Str() $uniform_name)
    is also<get-uniform-location>
  {
    cogl_pipeline_get_uniform_location($!cp, $uniform_name);
  }

  # COGL::Snippet NYI
  method add_layer_snippet (Int() $layer, CoglSnippet() $snippet)
    is also<add-layer-snippet>
  {
    my gint $l = resolve-int($layer);

    cogl_pipeline_add_layer_snippet($!cp, $l, $snippet);
  }

  method get_layer_mag_filter (Int() $layer_index)
    is also<get-layer-mag-filter>
  {
    my gint $li = resolve-int($layer_index);

    cogl_pipeline_get_layer_mag_filter($!cp, $li);
  }

  method get_layer_min_filter (gint $layer_index)
    is also<get-layer-min-filter>
  {
    my gint $li = resolve-int($layer_index);
    cogl_pipeline_get_layer_min_filter($!cp, $li);
  }

  method get_layer_point_sprite_coords_enabled (Int() $layer_index)
    is also<get-layer-point-sprite-coords-enabled>
  {
    my gint $li = resolve-int($layer_index);
    cogl_pipeline_get_layer_point_sprite_coords_enabled($!cp, $li);
  }

  method get_layer_texture (Int() $layer_index) is also<get-layer-texture> {
    my gint $li = resolve-int($layer_index);

    cogl_pipeline_get_layer_texture($!cp, $li);
  }

  method get_layer_wrap_mode_p (gint $layer_index)
    is also<get-layer-wrap-mode-p>
  {
    my gint $li = resolve-int($layer_index);

    cogl_pipeline_get_layer_wrap_mode_p($!cp, $li);
  }

  method get_layer_wrap_mode_s (Int() $layer_index)
    is also<get-layer-wrap-mode-s>
  {
    my gint $li = resolve-int($layer_index);

    cogl_pipeline_get_layer_wrap_mode_s($!cp, $li);
  }

  method get_layer_wrap_mode_t (Int() $layer_index)
    is also<get-layer-wrap-mode-t>
  {
    my gint $li = resolve-int($layer_index);

    cogl_pipeline_get_layer_wrap_mode_t($!cp, $li);
  }

  method get_n_layers () is also<get-n-layers> {
    cogl_pipeline_get_n_layers($!cp);
  }

  method remove_layer (Int() $layer_index) is also<remove-layer> {
    my gint $li = resolve-int($layer_index);

    cogl_pipeline_remove_layer($!cp, $li);
  }

  method set_layer_combine (
    Int() $layer_index,
    Str $blend_string,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<set-layer-combine>
  {
    my gint $li = resolve-int($layer_index);
    cogl_pipeline_set_layer_combine($!cp, $li, $blend_string, $error);
  }

  method set_layer_combine_constant (Int() $layer_index, CoglColor() $constant)
    is also<set-layer-combine-constant>
  {
    my gint $li = resolve-int($layer_index);
    cogl_pipeline_set_layer_combine_constant($!cp, $li, $constant);
  }

  method set_layer_filters (
    Int() $layer_index,
    Int() $min_filter,
    Int() $mag_filter
  )
    is also<set-layer-filters>
  {
    my gint $li = resolve-int($layer_index);
    my guint ($mnf, $mgf) = resolve-uint($min_filter, $mag_filter);

    cogl_pipeline_set_layer_filters($!cp, $li, $mnf, $mgf);
  }

  method set_layer_matrix (Int() $layer_index, CoglMatrix() $matrix)
    is also<set-layer-matrix>
  {
    my gint $li = resolve-int($layer_index);
    cogl_pipeline_set_layer_matrix($!cp, $li, $matrix);
  }

  method set_layer_null_texture (
    Int() $layer_index,
    Int() $texture_type
  )
    is also<set-layer-null-texture>
  {
    my gint $li = resolve-int($layer_index);
    my guint $tt = resolve-uint($texture_type);

    cogl_pipeline_set_layer_null_texture($!cp, $li, $tt);
  }

  method set_layer_point_sprite_coords_enabled (
    Int() $layer_index,
    Int() $enable,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<set-layer-point-sprite-coords-enabled>
  {
    my gint $li = resolve-int($layer_index);
    my gboolean $e = resolve-bool($enable);

    cogl_pipeline_set_layer_point_sprite_coords_enabled($!cp, $li, $e, $error);
  }

  method set_layer_texture (Int() $layer_index, CoglTexture() $texture)
    is also<set-layer-texture>
  {
    my gint $li = resolve-int($layer_index);

    cogl_pipeline_set_layer_texture($!cp, $li, $texture);
  }

  method set_layer_wrap_mode (Int() $layer_index, Int() $mode)
    is also<set-layer-wrap-mode>
  {
    my gint $li = resolve-int($layer_index);
    my guint $m = resolve-uint($mode);

    cogl_pipeline_set_layer_wrap_mode($!cp, $li, $m);
  }

  method set_layer_wrap_mode_p (
    Int() $layer_index,
    Int() $mode
  )
    is also<set-layer-wrap-mode-p>
  {
    my gint $li = resolve-int($layer_index);
    my guint $m = resolve-uint($mode);

    cogl_pipeline_set_layer_wrap_mode_p($!cp, $li, $m);
  }

  method set_layer_wrap_mode_s (
    Int() $layer_index,
    Int() $mode
  )
    is also<set-layer-wrap-mode-s>
  {
    my gint $li = resolve-int($layer_index);
    my guint $m = resolve-uint($mode);

    cogl_pipeline_set_layer_wrap_mode_s($!cp, $li, $m);
  }

  method set_layer_wrap_mode_t (
    Int() $layer_index,
    Int() $mode
  )
    is also<set-layer-wrap-mode-t>
  {
    my gint $li = resolve-int($layer_index);
    my guint $m = resolve-uint($mode);

    cogl_pipeline_set_layer_wrap_mode_t($!cp, $li, $m);
  }

}
