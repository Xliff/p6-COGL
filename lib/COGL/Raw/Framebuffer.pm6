use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Framebuffer;

sub cogl_framebuffer_allocate (
  CoglFramebuffer $framebuffer,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_get_draw_framebuffer ()
  returns CoglFramebuffer
  is native(cogl)
  is export
{ * }

sub cogl_is_framebuffer (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_attributes (
  CoglFramebuffer $framebuffer, CoglPipeline $pipeline,
  CoglVerticesMode $mode,
  gint $first_vertex,
  gint $n_vertices,
  CoglAttribute $attributes,
  gint $n_attributes
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_indexed_attributes (
  CoglFramebuffer $framebuffer,
  CoglPipeline $pipeline,
  CoglVerticesMode $mode,
  gint $first_vertex,
  gint $n_vertices,
  CoglIndices $indices,
  CoglAttribute $attributes,
  gint $n_attributes
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_multitextured_rectangle (
  CoglFramebuffer $framebuffer,
  CoglPipeline $pipeline,
  gfloat $x_1,
  gfloat $y_1,
  gfloat $x_2,
  gfloat $y_2,
  gfloat $tex_coords,
  gint $tex_coords_len
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_primitive (
  CoglFramebuffer $framebuffer,
  CoglPipeline $pipeline,
  CoglPrimitive $primitive
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_rectangle (
  CoglFramebuffer $framebuffer,
  CoglPipeline $pipeline,
  gfloat $x_1,
  gfloat $y_1,
  gfloat $x_2,
  gfloat $y_2
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_textured_rectangle (
  CoglFramebuffer $framebuffer,
  CoglPipeline $pipeline,
  gfloat $x_1,
  gfloat $y_1,
  gfloat $x_2,
  gfloat $y_2,
  gfloat $s_1,
  gfloat $t_1,
  gfloat $s_2,
  gfloat $t_2
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_error_quark ()
  returns uint32_t
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_finish (CoglFramebuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_frustum (
  CoglFramebuffer $framebuffer,
  gfloat $left,
  gfloat $right,
  gfloat $bottom,
  gfloat $top,
  gfloat $z_near,
  gfloat $z_far
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_alpha_bits (CoglFramebuffer $framebuffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_blue_bits (CoglFramebuffer $framebuffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_context (CoglFramebuffer $framebuffer)
  returns CoglContext
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_depth_bits (CoglFramebuffer $framebuffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_depth_texture (CoglFramebuffer $framebuffer)
  returns CoglTexture
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_green_bits (CoglFramebuffer $framebuffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_height (CoglFramebuffer $framebuffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_is_stereo (CoglFramebuffer $framebuffer)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_modelview_matrix (
  CoglFramebuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_projection_matrix (
  CoglFramebuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_red_bits (CoglFramebuffer $framebuffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport4fv (
  CoglFramebuffer $framebuffer,
  gfloat $viewport
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport_height (CoglFramebuffer $framebuffer)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport_width (CoglFramebuffer $framebuffer)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport_x (CoglFramebuffer $framebuffer)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport_y (CoglFramebuffer $framebuffer)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_width (CoglFramebuffer $framebuffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_identity_matrix (CoglFramebuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_orthographic (
  CoglFramebuffer $framebuffer,
  gfloat $x_1,
  gfloat $y_1,
  gfloat $x_2,
  gfloat $y_2,
  gfloat $near,
  gfloat $far
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_perspective (
  CoglFramebuffer $framebuffer,
  gfloat $fov_y,
  gfloat $aspect,
  gfloat $z_near,
  gfloat $z_far
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_pop_clip (CoglFramebuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_pop_matrix (CoglFramebuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_push_matrix (CoglFramebuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_push_primitive_clip (
  CoglFramebuffer $framebuffer,
  CoglPrimitive $primitive,
  gfloat $bounds_x1,
  gfloat $bounds_y1,
  gfloat $bounds_x2,
  gfloat $bounds_y2
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_push_rectangle_clip (
  CoglFramebuffer $framebuffer,
  gfloat $x_1,
  gfloat $y_1,
  gfloat $x_2,
  gfloat $y_2
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_push_scissor_clip (
  CoglFramebuffer $framebuffer,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_read_pixels (
  CoglFramebuffer $framebuffer,
  gint $x,
  gint $y,
  gint $width,
  gint $height,
  CoglPixelFormat $format,
  uint8_t $pixels
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_read_pixels_into_bitmap (
  CoglFramebuffer $framebuffer,
  gint $x,
  gint $y,
  CoglReadPixelsFlags $source,
  CoglBitmap $bitmap
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_resolve_samples (CoglFramebuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_resolve_samples_region (
  CoglFramebuffer $framebuffer,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_rotate (
  CoglFramebuffer $framebuffer,
  gfloat $angle,
  gfloat $x,
  gfloat $y,
  gfloat $z
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_rotate_euler (
  CoglFramebuffer $framebuffer,
  CoglEuler $euler
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_rotate_quaternion (
  CoglFramebuffer $framebuffer,
  CoglQuaternion $quaternion
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_scale (
  CoglFramebuffer $framebuffer,
  gfloat $x,
  gfloat $y,
  gfloat $z
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_modelview_matrix (
  CoglFramebuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_projection_matrix (
  CoglFramebuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_viewport (
  CoglFramebuffer $framebuffer,
  gfloat $x,
  gfloat $y,
  gfloat $width,
  gfloat $height
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_transform (
  CoglFramebuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_translate (
  CoglFramebuffer $framebuffer,
  gfloat $x,
  gfloat $y,
  gfloat $z
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_color_mask (CoglFramebuffer $framebuffer)
  returns CoglColorMask
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_depth_texture_enabled (CoglFramebuffer $framebuffer)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_depth_write_enabled (CoglFramebuffer $framebuffer)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_dither_enabled (CoglFramebuffer $framebuffer)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_samples_per_pixel (CoglFramebuffer $framebuffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_stereo_mode (CoglFramebuffer $framebuffer)
  returns CoglStereoMode
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_color_mask (
  CoglFramebuffer $framebuffer,
  CoglColorMask $color_mask
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_depth_texture_enabled (
  CoglFramebuffer $framebuffer,
  CoglBool $enabled
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_depth_write_enabled (
  CoglFramebuffer $framebuffer,
  CoglBool $depth_write_enabled
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_dither_enabled (
  CoglFramebuffer $framebuffer,
  CoglBool $dither_enabled
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_samples_per_pixel (
  CoglFramebuffer $framebuffer,
  gint $samples_per_pixel
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_stereo_mode (
  CoglFramebuffer $framebuffer,
  CoglStereoMode $stereo_mode
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_clear(
  CoglFramebuffer $framebuffer,
  gulong $buffer_mask,
  CoglColor $color
) 
  is native(cogl)
  is export 
{ * }

sub cogl_framebuffer_clear4f (
  CoglFramebuffer $framebuffer,
  gulong $buffers,
  gfloat $red,
  gfloat $green,
  gfloat $blue,
  gfloat $alpha
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_rectangles (
  CoglFramebuffer $framebuffer,
  CoglPipeline $pipeline,
  CArray[gfloat] $coordinates,
  guint $n_rectangles
)
  is native(cogl)
  is export 
{ * }

sub cogl_framebuffer_draw_textured_rectangles (
  CoglFramebuffer $framebuffer,
  CoglPipeline $pipeline,
  CArray[gfloat] $coordinates,
  guint $n_rectangles
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_discard_buffers (
  CoglFramebuffer $framebuffer,
  gulong $buffer_mask
)
  is native(cogl)
  is export
{ * }
