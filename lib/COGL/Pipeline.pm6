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
    my $pipeline = cogl_pipeline_new($context);
    say $pipeline;
    self.bless( :$pipeline );
  }

  method is_pipeline (COGL::Pipeline:U: gpointer $candidate)
    is also<is-pipeline>
  {
    so cogl_is_pipeline($candidate);
  }

  method color_mask is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglColorMask( cogl_pipeline_get_color_mask($!cp) );
      },
      STORE => sub ($, Int() $color_mask is copy) {
        my uint64 $m = resolve-uint64($color_mask);
        cogl_pipeline_set_color_mask($!cp, $m);
      }
    );
  }

  method cull_face_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglPipelineCullFaceMode( cogl_pipeline_get_cull_face_mode($!cp) );
      },
      STORE => sub ($, Int() $cull_face_mode is copy) {
        my guint $m = resolve-uint($cull_face_mode);
        cogl_pipeline_set_cull_face_mode($!cp, $m);
      }
    );
  }

  method front_face_winding is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglWinding( cogl_pipeline_get_front_face_winding($!cp) );
      },
      STORE => sub ($, Int() $front_winding is copy) {
        my guint $w = resolve-uint($front_winding);
        cogl_pipeline_set_front_face_winding($!cp, $w);
      }
    );
  }

  method point_size is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_pipeline_get_point_size($!cp);
      },
      STORE => sub ($, Num() $point_size is copy) {
        my gfloat $p = $point_size;
        cogl_pipeline_set_point_size($!cp, $p);
      }
    );
  }

  method shininess is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_pipeline_get_shininess($!cp);
      },
      STORE => sub ($, Num() $shininess is copy) {
        my gfloat $s = $shininess;
        cogl_pipeline_set_shininess($!cp, $s);
      }
    );
  }

  method user_program is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_pipeline_get_user_program($!cp);
      },
      STORE => sub ($, CoglHandle $program is copy) {
        cogl_pipeline_set_user_program($!cp, $program);
      }
    );
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

  method get_layer_min_filter (Int() $layer_index)
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

  method get_layer_wrap_mode_p (Int() $layer_index)
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

  method add_snippet (CoglSnippet() $snippet) is also<add-snippet> {
    cogl_pipeline_add_snippet($!cp, $snippet);
  }

  method get_alpha_test_function is also<get-alpha-test-function> {
    CoglPipelineAlphaFunc( cogl_pipeline_get_alpha_test_function($!cp) );
  }

  method get_alpha_test_reference is also<get-alpha-test-reference> {
    cogl_pipeline_get_alpha_test_reference($!cp);
  }

  method get_ambient (CoglColor() $ambient) is also<get-ambient> {
    cogl_pipeline_get_ambient($!cp, $ambient);
  }

  method get_color (CoglColor() $color) is also<get-color> {
    cogl_pipeline_get_color($!cp, $color);
  }

  method get_depth_state (Int() $state_out) is also<get-depth-state> {
    my guint $so = resolve-uint($state_out);
    cogl_pipeline_get_depth_state($!cp, $state_out);
  }

  method get_diffuse (CoglColor() $diffuse) is also<get-diffuse> {
    cogl_pipeline_get_diffuse($!cp, $diffuse);
  }

  method get_emission (CoglColor() $emission) is also<get-emission> {
    cogl_pipeline_get_emission($!cp, $emission);
  }

  method get_per_vertex_point_size is also<get-per-vertex-point-size> {
    cogl_pipeline_get_per_vertex_point_size($!cp);
  }

  method get_specular (CoglColor() $specular) is also<get-specular> {
    cogl_pipeline_get_specular($!cp, $specular);
  }

  method set_alpha_test_function (
    Int() $alpha_func,
    Num() $alpha_reference
  )
    is also<set-alpha-test-function>
  {
    my guint $af = resolve-uint($alpha_func);
    my gfloat $ar = $alpha_reference;

    cogl_pipeline_set_alpha_test_function($!cp, $af, $ar);
  }

  method set_ambient (CoglColor() $ambient) is also<set-ambient> {
    cogl_pipeline_set_ambient($!cp, $ambient);
  }

  method set_ambient_and_diffuse (CoglColor() $color)
    is also<set-ambient-and-diffuse>
  {
    cogl_pipeline_set_ambient_and_diffuse($!cp, $color);
  }

  method set_blend (
    Str() $blend_string,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<set-blend>
  {
    clear_error;
    my $rc = cogl_pipeline_set_blend($!cp, $blend_string, $error);
    set_error($error);
    $rc;
  }

  method set_blend_constant (CoglColor() $constant_color)
    is also<set-blend-constant>
  {
    cogl_pipeline_set_blend_constant($!cp, $constant_color);
  }

  method set_color (CoglColor $color) is also<set-color> {
    cogl_pipeline_set_color($!cp, $color);
  }

  method set_color4f (
    Num() $red,
    Num() $green,
    Num() $blue,
    Num() $alpha
  )
    is also<set-color4f>
  {
    my gfloat ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);

    cogl_pipeline_set_color4f($!cp, $r, $g, $b, $a);
  }

  method set_color4ub (
    Int() $red,
    Int() $green,
    Int() $blue,
    Int() $alpha
  )
    is also<set-color4ub>
  {
    my uint8 ($r, $g, $b, $a) = resolve-uint8($red, $green, $blue, $alpha);

    cogl_pipeline_set_color4ub($!cp, $r, $g, $b, $a);
  }

  method set_depth_state (
    Int() $state,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<set-depth-state>
  {
    my gint $s = resolve-uint($state);

    clear_error;
    my $rc = cogl_pipeline_set_depth_state($!cp, $s, $error);
    set_error($error);
    $rc;
  }

  method set_diffuse (CoglColor() $diffuse) is also<set-diffuse> {
    cogl_pipeline_set_diffuse($!cp, $diffuse);
  }

  method set_emission (CoglColor() $emission) is also<set-emission> {
    cogl_pipeline_set_emission($!cp, $emission);
  }

  method set_per_vertex_point_size (
    Int() $enable,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<set-per-vertex-point-size>
  {
    my gboolean $e = resolve-bool($enable);

    clear_error;
    my $rc = cogl_pipeline_set_per_vertex_point_size($!cp, $e, $error);
    set_error($error);
    $rc;
  }

  method set_specular (CoglColor() $specular) is also<set-specular> {
    cogl_pipeline_set_specular($!cp, $specular);
  }

  method set_uniform_1f (Int() $uniform_location, Num() $value)
    is also<set-uniform-1f>
  {
    my gint $u = resolve-int($uniform_location);
    my gfloat $v = $value;

    cogl_pipeline_set_uniform_1f($!cp, $uniform_location, $value);
  }

  method set_uniform_1i (Int() $uniform_location, Int() $value)
    is also<set-uniform-1i>
  {
    my gint ($u, $v) = resolve-int($uniform_location, $value);

    cogl_pipeline_set_uniform_1i($!cp, $uniform_location, $value);
  }

  method set_uniform_float (
    Int() $uniform_location,
    Int() $n_components,
    Int() $count,
    CArray[gfloat] $value
  )
    is also<set-uniform-float>
  {
    my gint ($u, $n, $c) = resolve-int($uniform_location, $n_components, $count);
    cogl_pipeline_set_uniform_float($!cp, $u, $n, $c, $value);
  }

  method set_uniform_int (
    Int() $uniform_location,
    Int() $n_components,
    Int() $count,
    CArray[gint] $value
  )
    is also<set-uniform-int>
  {
    my gint ($u, $n, $c) = resolve-int($uniform_location, $n_components, $count);

    cogl_pipeline_set_uniform_int(
      $!cp,
      $uniform_location,
      $n_components,
      $count,
      $value
    );
  }

  method set_uniform_matrix (
    Int() $uniform_location,
    Int() $dimensions,
    Int() $count,
    Int() $transpose,
    CArray[gfloat] $value
  )
    is also<set-uniform-matrix>
  {
    my gint ($u, $d, $c) = resolve-int($uniform_location, $dimensions, $count);
    my gboolean $t = resolve-bool($transpose);

    cogl_pipeline_set_uniform_matrix($!cp, $u, $d, $c, $t, $value);
  }

}
