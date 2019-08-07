use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::FrameBuffer;

class COGL::FrameBuffer {
  has CoglFramebuffer $!cf;

  method color_mask is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_framebuffer_get_color_mask($!cf);
      },
      STORE => sub ($, $color_mask is copy) {
        cogl_framebuffer_set_color_mask($!cf, $color_mask);
      }
    );
  }

  method depth_texture_enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_framebuffer_get_depth_texture_enabled($!cf);
      },
      STORE => sub ($, $enabled is copy) {
        cogl_framebuffer_set_depth_texture_enabled($!cf, $enabled);
      }
    );
  }

  method depth_write_enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_framebuffer_get_depth_write_enabled($!cf);
      },
      STORE => sub ($, $depth_write_enabled is copy) {
        cogl_framebuffer_set_depth_write_enabled($!cf, $depth_write_enabled);
      }
    );
  }

  method dither_enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_framebuffer_get_dither_enabled($!cf);
      },
      STORE => sub ($, $dither_enabled is copy) {
        cogl_framebuffer_set_dither_enabled($!cf, $dither_enabled);
      }
    );
  }

  method samples_per_pixel is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_framebuffer_get_samples_per_pixel($!cf);
      },
      STORE => sub ($, $samples_per_pixel is copy) {
        cogl_framebuffer_set_samples_per_pixel($!cf, $samples_per_pixel);
      }
    );
  }

  method stereo_mode is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_framebuffer_get_stereo_mode($!cf);
      },
      STORE => sub ($, $stereo_mode is copy) {
        cogl_framebuffer_set_stereo_mode($!cf, $stereo_mode);
      }
    );
  }

  method allocate (CoglError $error) {
    cogl_framebuffer_allocate($!cf, $error);
  }

  method cogl_get_draw_framebuffer {
    cogl_get_draw_framebuffer($!cf);
  }

  method cogl_is_framebuffer {
    cogl_is_framebuffer($!cf);
  }

  method draw_attributes (
    CoglPipeline $pipeline,
    CoglVerticesMode $mode,
    gint $first_vertex,
    gint $n_vertices,
    CoglAttribute $attributes,
    gint $n_attributes
  ) {
    cogl_framebuffer_draw_attributes(
      $!cf,
      $pipeline,
      $mode,
      $first_vertex,
      $n_vertices,
      $attributes,
      $n_attributes
    );
  }

  method draw_indexed_attributes (
    CoglPipeline $pipeline,
    CoglVerticesMode $mode,
    gint $first_vertex,
    gint $n_vertices,
    CoglIndices $indices,
    CoglAttribute $attributes,
    gint $n_attributes
  ) {
    cogl_framebuffer_draw_indexed_attributes(
      $!cf,
      $pipeline,
      $mode,
      $first_vertex,
      $n_vertices,
      $indices,
      $attributes,
      $n_attributes
    );
  }

  method draw_multitextured_rectangle (
    CoglPipeline $pipeline,
    gfloat $x_1,
    gfloat $y_1,
    gfloat $x_2,
    gfloat $y_2,
    gfloat $tex_coords,
    gint $tex_coords_len
  ) {
    cogl_framebuffer_draw_multitextured_rectangle(
      $!cf,
      $pipeline,
      $x_1,
      $y_1,
      $x_2,
      $y_2,
      $tex_coords,
      $tex_coords_len
    );
  }

  method draw_primitive (CoglPipeline $pipeline, CoglPrimitive $primitive) {
    cogl_framebuffer_draw_primitive($!cf, $pipeline, $primitive);
  }

  method draw_rectangle (
    CoglPipeline $pipeline,
    gfloat $x_1,
    gfloat $y_1,
    gfloat $x_2,
    gfloat $y_2
  ) {
    cogl_framebuffer_draw_rectangle($!cf, $pipeline, $x_1, $y_1, $x_2, $y_2);
  }

  method draw_textured_rectangle (
    CoglPipeline $pipeline,
    gfloat $x_1,
    gfloat $y_1,
    gfloat $x_2,
    gfloat $y_2,
    gfloat $s_1,
    gfloat $t_1,
    gfloat $s_2,
    gfloat $t_2
  ) {
    cogl_framebuffer_draw_textured_rectangle(
      $!cf,
      $pipeline,
      $x_1,
      $y_1,
      $x_2,
      $y_2,
      $s_1,
      $t_1,
      $s_2,
      $t_2
    );
  }

  method error_quark(COGL::FrameBuffer:U:) {
    cogl_framebuffer_error_quark();
  }

  method finish {
    cogl_framebuffer_finish($!cf);
  }

  method frustum (
    gfloat $left,
    gfloat $right,
    gfloat $bottom,
    gfloat $top,
    gfloat $z_near,
    gfloat $z_far
  ) {
    cogl_framebuffer_frustum(
      $!cf,
      $left,
      $right,
      $bottom,
      $top,
      $z_near,
      $z_far
    );
  }

  method get_alpha_bits {
    cogl_framebuffer_get_alpha_bits($!cf);
  }

  method get_blue_bits {
    cogl_framebuffer_get_blue_bits($!cf);
  }

  method get_context {
    cogl_framebuffer_get_context($!cf);
  }

  method get_depth_bits {
    cogl_framebuffer_get_depth_bits($!cf);
  }

  method get_depth_texture {
    cogl_framebuffer_get_depth_texture($!cf);
  }

  method get_green_bits {
    cogl_framebuffer_get_green_bits($!cf);
  }

  method get_gtype {
    cogl_framebuffer_get_gtype($!cf);
  }

  method get_height {
    cogl_framebuffer_get_height($!cf);
  }

  method get_is_stereo {
    cogl_framebuffer_get_is_stereo($!cf);
  }

  method get_modelview_matrix (CoglMatrix $matrix) {
    cogl_framebuffer_get_modelview_matrix($!cf, $matrix);
  }

  method get_projection_matrix (CoglMatrix $matrix) {
    cogl_framebuffer_get_projection_matrix($!cf, $matrix);
  }

  method get_red_bits {
    cogl_framebuffer_get_red_bits($!cf);
  }

  method get_viewport4fv (gfloat $viewport) {
    cogl_framebuffer_get_viewport4fv($!cf, $viewport);
  }

  method get_viewport_height {
    cogl_framebuffer_get_viewport_height($!cf);
  }

  method get_viewport_width {
    cogl_framebuffer_get_viewport_width($!cf);
  }

  method get_viewport_x {
    cogl_framebuffer_get_viewport_x($!cf);
  }

  method get_viewport_y {
    cogl_framebuffer_get_viewport_y($!cf);
  }

  method get_width {
    cogl_framebuffer_get_width($!cf);
  }

  method identity_matrix {
    cogl_framebuffer_identity_matrix($!cf);
  }

  method orthographic (
    gfloat $x_1,
    gfloat $y_1,
    gfloat $x_2,
    gfloat $y_2,
    gfloat $near,
    gfloat $far
  ) {
    cogl_framebuffer_orthographic(
      $!cf,
      $x_1,
      $y_1,
      $x_2,
      $y_2,
      $near,
      $far
    );
  }

  method perspective (
    gfloat $fov_y,
    gfloat $aspect,
    gfloat $z_near,
    gfloat $z_far
  ) {
    cogl_framebuffer_perspective($!cf, $fov_y, $aspect, $z_near, $z_far);
  }

  method pop_clip {
    cogl_framebuffer_pop_clip($!cf);
  }

  method pop_matrix {
    cogl_framebuffer_pop_matrix($!cf);
  }

  method push_matrix {
    cogl_framebuffer_push_matrix($!cf);
  }

  method push_primitive_clip (
    CoglPrimitive $primitive,
    gfloat $bounds_x1,
    gfloat $bounds_y1,
    gfloat $bounds_x2,
    gfloat $bounds_y2
  ) {
    cogl_framebuffer_push_primitive_clip(
      $!cf,
      $primitive,
      $bounds_x1,
      $bounds_y1,
      $bounds_x2,
      $bounds_y2
    );
  }

  method push_rectangle_clip (
    gfloat $x_1,
    gfloat $y_1,
    gfloat $x_2,
    gfloat $y_2
  ) {
    cogl_framebuffer_push_rectangle_clip($!cf, $x_1, $y_1, $x_2, $y_2);
  }

  method push_scissor_clip (gint $x, gint $y, gint $width, gint $height) {
    cogl_framebuffer_push_scissor_clip($!cf, $x, $y, $width, $height);
  }

  method read_pixels (
    gint $x,
    gint $y,
    gint $width,
    gint $height,
    CoglPixelFormat $format,
    uint8_t $pixels
  ) {
    cogl_framebuffer_read_pixels(
      $!cf,
      $x,
      $y,
      $width,
      $height,
      $format,
      $pixels
    );
  }

  method read_pixels_into_bitmap (
    gint $x,
    gint $y,
    CoglReadPixelsFlags $source,
    CoglBitmap $bitmap
  ) {
    cogl_framebuffer_read_pixels_into_bitmap($!cf, $x, $y, $source, $bitmap);
  }

  method resolve_samples {
    cogl_framebuffer_resolve_samples($!cf);
  }

  method resolve_samples_region (gint $x, gint $y, gint $width, gint $height) {
    cogl_framebuffer_resolve_samples_region($!cf, $x, $y, $width, $height);
  }

  method rotate (gfloat $angle, gfloat $x, gfloat $y, gfloat $z) {
    cogl_framebuffer_rotate($!cf, $angle, $x, $y, $z);
  }

  method rotate_euler (CoglEuler $euler) {
    cogl_framebuffer_rotate_euler($!cf, $euler);
  }

  method rotate_quaternion (CoglQuaternion $quaternion) {
    cogl_framebuffer_rotate_quaternion($!cf, $quaternion);
  }

  method scale (gfloat $x, gfloat $y, gfloat $z) {
    cogl_framebuffer_scale($!cf, $x, $y, $z);
  }

  method set_modelview_matrix (CoglMatrix $matrix) {
    cogl_framebuffer_set_modelview_matrix($!cf, $matrix);
  }

  method set_projection_matrix (CoglMatrix $matrix) {
    cogl_framebuffer_set_projection_matrix($!cf, $matrix);
  }

  method set_viewport (gfloat $x, gfloat $y, gfloat $width, gfloat $height) {
    cogl_framebuffer_set_viewport($!cf, $x, $y, $width, $height);
  }

  method transform (CoglMatrix $matrix) {
    cogl_framebuffer_transform($!cf, $matrix);
  }

  method translate (gfloat $x, gfloat $y, gfloat $z) {
    cogl_framebuffer_translate($!cf, $x, $y, $z);
  }

}
