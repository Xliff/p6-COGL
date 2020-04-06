use v6.c;

use NativeCall;


use COGL::Raw::Types;

unit package COGL::Raw::FrameBuffer;

sub cogl_framebuffer_allocate (
  CoglFrameBuffer $framebuffer,
  CArray[Pointer[CoglError]] $error
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_get_draw_framebuffer ()
  returns CoglFrameBuffer
  is native(cogl)
  is export
{ * }

sub cogl_is_framebuffer (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_attributes (
  CoglFrameBuffer $framebuffer,
  CoglPipeline $pipeline,
  guint $mode, # CoglVerticesMode $mode,
  gint $first_vertex,
  gint $n_vertices,
  CoglAttribute $attributes,
  gint $n_attributes
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_indexed_attributes (
  CoglFrameBuffer $framebuffer,
  CoglPipeline $pipeline,
  guint $mode, # CoglVerticesMode $mode,
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
  CoglFrameBuffer $framebuffer,
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
  CoglFrameBuffer $framebuffer,
  CoglPipeline $pipeline,
  CoglPrimitive $primitive
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_rectangle (
  CoglFrameBuffer $framebuffer,
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
  CoglFrameBuffer $framebuffer,
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
  returns uint32
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_finish (CoglFrameBuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_frustum (
  CoglFrameBuffer $framebuffer,
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

sub cogl_framebuffer_get_alpha_bits (CoglFrameBuffer $framebuffer)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_blue_bits (CoglFrameBuffer $framebuffer)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_context (CoglFrameBuffer $framebuffer)
  returns CoglContext
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_depth_bits (CoglFrameBuffer $framebuffer)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_depth_texture (CoglFrameBuffer $framebuffer)
  returns CoglTexture
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_green_bits (CoglFrameBuffer $framebuffer)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_height (CoglFrameBuffer $framebuffer)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_is_stereo (CoglFrameBuffer $framebuffer)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_modelview_matrix (
  CoglFrameBuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_projection_matrix (
  CoglFrameBuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_red_bits (CoglFrameBuffer $framebuffer)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport4fv (
  CoglFrameBuffer $framebuffer,
  gfloat $viewport
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport_height (CoglFrameBuffer $framebuffer)
  returns gfloat
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport_width (CoglFrameBuffer $framebuffer)
  returns gfloat
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport_x (CoglFrameBuffer $framebuffer)
  returns gfloat
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_viewport_y (CoglFrameBuffer $framebuffer)
  returns gfloat
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_width (CoglFrameBuffer $framebuffer)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_identity_matrix (CoglFrameBuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_orthographic (
  CoglFrameBuffer $framebuffer,
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
  CoglFrameBuffer $framebuffer,
  gfloat $fov_y,
  gfloat $aspect,
  gfloat $z_near,
  gfloat $z_far
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_pop_clip (CoglFrameBuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_pop_matrix (CoglFrameBuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_push_matrix (CoglFrameBuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_push_primitive_clip (
  CoglFrameBuffer $framebuffer,
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
  CoglFrameBuffer $framebuffer,
  gfloat $x_1,
  gfloat $y_1,
  gfloat $x_2,
  gfloat $y_2
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_push_scissor_clip (
  CoglFrameBuffer $framebuffer,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_read_pixels (
  CoglFrameBuffer $framebuffer,
  gint $x,
  gint $y,
  gint $width,
  gint $height,
  guint $format, # CoglPixelFormat $format,
  CArray[uint8] $pixels
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_read_pixels_into_bitmap (
  CoglFrameBuffer $framebuffer,
  gint $x,
  gint $y,
  guint $source, # CoglReadPixelsFlags $source,
  CoglBitmap $bitmap
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_resolve_samples (CoglFrameBuffer $framebuffer)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_resolve_samples_region (
  CoglFrameBuffer $framebuffer,
  gint $x,
  gint $y,
  gint $width,
  gint $height
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_rotate (
  CoglFrameBuffer $framebuffer,
  gfloat $angle,
  gfloat $x,
  gfloat $y,
  gfloat $z
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_rotate_euler (
  CoglFrameBuffer $framebuffer,
  CoglEuler $euler
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_rotate_quaternion (
  CoglFrameBuffer $framebuffer,
  CoglQuaternion $quaternion
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_scale (
  CoglFrameBuffer $framebuffer,
  gfloat $x,
  gfloat $y,
  gfloat $z
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_modelview_matrix (
  CoglFrameBuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_projection_matrix (
  CoglFrameBuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_viewport (
  CoglFrameBuffer $framebuffer,
  gfloat $x,
  gfloat $y,
  gfloat $width,
  gfloat $height
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_transform (
  CoglFrameBuffer $framebuffer,
  CoglMatrix $matrix
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_translate (
  CoglFrameBuffer $framebuffer,
  gfloat $x,
  gfloat $y,
  gfloat $z
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_color_mask (CoglFrameBuffer $framebuffer)
  returns int64 # CoglColorMask
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_depth_texture_enabled (CoglFrameBuffer $framebuffer)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_depth_write_enabled (CoglFrameBuffer $framebuffer)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_dither_enabled (CoglFrameBuffer $framebuffer)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_samples_per_pixel (CoglFrameBuffer $framebuffer)
  returns gint
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_get_stereo_mode (CoglFrameBuffer $framebuffer)
  returns guint # CoglStereoMode
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_color_mask (
  CoglFrameBuffer $framebuffer,
  int64 $color_mask # CoglColorMask $color_mask
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_depth_texture_enabled (
  CoglFrameBuffer $framebuffer,
  CoglBool $enabled
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_depth_write_enabled (
  CoglFrameBuffer $framebuffer,
  CoglBool $depth_write_enabled
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_dither_enabled (
  CoglFrameBuffer $framebuffer,
  CoglBool $dither_enabled
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_samples_per_pixel (
  CoglFrameBuffer $framebuffer,
  gint $samples_per_pixel
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_set_stereo_mode (
  CoglFrameBuffer $framebuffer,
  guint $stereo_mode # CoglStereoMode $stereo_mode
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_clear(
  CoglFrameBuffer $framebuffer,
  gulong $buffer_mask,
  CoglColor $color
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_clear4f (
  CoglFrameBuffer $framebuffer,
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
  CoglFrameBuffer $framebuffer,
  CoglPipeline $pipeline,
  CArray[gfloat] $coordinates,
  guint $n_rectangles
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_draw_textured_rectangles (
  CoglFrameBuffer $framebuffer,
  CoglPipeline $pipeline,
  CArray[gfloat] $coordinates,
  guint $n_rectangles
)
  is native(cogl)
  is export
{ * }

sub cogl_framebuffer_discard_buffers (
  CoglFrameBuffer $framebuffer,
  gulong $buffer_mask
)
  is native(cogl)
  is export
{ * }
