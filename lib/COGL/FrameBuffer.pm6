use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::FrameBuffer;

use COGL::Object;

use COGL::Roles::Buffer;

our subset FrameBufferAncestry of Mu
  where CoglFrameBuffer | CoglBuffer | CoglObject;

class COGL::FrameBuffer is COGL::Object {
  also does COGL::Roles::Buffer;

  has CoglFrameBuffer $!cf;

  submethod BUILD (CoglFrameBuffer :$framebuffer) {
    self.setFramebuffer($framebuffer) if $framebuffer;
  }

  method COGL::Raw::Types::CoglFrameBuffer
    is also<CoglFrameBuffer>
  { $!cf }

  method setFrameBuffer(FrameBufferAncestry $_) {
    my $to-parent;
    $!cf = do {
      when CoglFrameBuffer {
        $to-parent = cast(CoglObject, $_);
        $_;
      }

      when CoglBuffer {
        $to-parent = cast(CoglObject, $_);
        $!cb = cast(CoglBuffer, $_);          # COGL::Roles::Buffer
        cast(CoglFrameBuffer, $_);
      }

      default {
        $to-parent = $_;
        cast(CoglFrameBuffer, $_);
      }
    };
    self.setObject($to-parent);
    $!cb //= cast(CoglBuffer, $!cf);          # COGL::Roles::Buffer
  }

  method new (CoglFrameBuffer $framebuffer) {
    self.bless( :$framebuffer );
  }

  method color_mask is rw is also<color-mask> {
    Proxy.new(
      FETCH => sub ($) {
        CoglColorMask( cogl_framebuffer_get_color_mask($!cf) );
      },
      STORE => sub ($, Int() $color_mask is copy) {
        my guint $cm = resolve-uint($color_mask);

        cogl_framebuffer_set_color_mask($!cf, $cm);
      }
    );
  }

  method depth_texture_enabled is rw is also<depth-texture-enabled> {
    Proxy.new(
      FETCH => sub ($) {
        so cogl_framebuffer_get_depth_texture_enabled($!cf);
      },
      STORE => sub ($, Int() $enabled is copy) {
        my gboolean $e = resolve-bool($enabled);

        cogl_framebuffer_set_depth_texture_enabled($!cf, $e);
      }
    );
  }

  method depth_write_enabled is rw is also<depth-write-enabled> {
    Proxy.new(
      FETCH => sub ($) {
        so cogl_framebuffer_get_depth_write_enabled($!cf);
      },
      STORE => sub ($, Int() $depth_write_enabled is copy) {
        my gboolean $e = resolve-bool($depth_write_enabled);

        cogl_framebuffer_set_depth_write_enabled($!cf, $e);
      }
    );
  }

  method dither_enabled is rw is also<dither-enabled> {
    Proxy.new(
      FETCH => sub ($) {
        so cogl_framebuffer_get_dither_enabled($!cf);
      },
      STORE => sub ($, $dither_enabled is copy) {
        my gboolean $e = resolve-bool($dither_enabled);

        cogl_framebuffer_set_dither_enabled($!cf, $e);
      }
    );
  }

  method modelview_matrix(:$raw = False) is rw is also<modelview-matrix> {
    Proxy.new:
      FETCH => -> $ { self.get-modelview-matrix(:$raw) },
      STORE => -> $, CoglMatrix() \mm { self.set-modelview-matrix(mm) };
  }

  method samples_per_pixel is rw is also<samples-per-pixel> {
    Proxy.new(
      FETCH => sub ($) {
        cogl_framebuffer_get_samples_per_pixel($!cf);
      },
      STORE => sub ($, Int() $samples_per_pixel is copy) {
        my gint $s = resolve-int($samples_per_pixel);

        cogl_framebuffer_set_samples_per_pixel($!cf, $s);
      }
    );
  }

  method stereo_mode is rw is also<stereo-mode> {
    Proxy.new(
      FETCH => sub ($) {
        CoglStereoMode( cogl_framebuffer_get_stereo_mode($!cf) );
      },
      STORE => sub ($, Int() $stereo_mode is copy) {
        my guint $sm = resolve-uint($stereo_mode);

        cogl_framebuffer_set_stereo_mode($!cf, $sm);
      }
    );
  }

  method allocate (
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    clear_error;
    my $rc = cogl_framebuffer_allocate($!cf, $error);
    set_error($error);
    so $rc;
  }

  method get_draw_framebuffer ( COGL::FrameBuffer:U: :$raw = False)
    is also<
      get-draw-framebuffer
      draw_framebuffer
      draw-framebuffer
    >
  {
    my $fb = cogl_get_draw_framebuffer();
    $fb ??
      ( $raw ?? $fb !! COGL::Framebuffer.new($fb) )
      !!
      Nil;
  }

  method is_framebuffer (
    COGL::FrameBuffer:U:
    gpointer $candidate
  )
    is also<cogl-is-framebuffer>
  {
    so cogl_is_framebuffer($candidate);
  }

  method draw_attributes (
    CoglPipeline() $pipeline,
    Int() $mode,
    Int() $first_vertex,
    Int() $n_vertices,
    CArray[Pointer[CoglAttribute]] $attributes,
    Int() $n_attributes
  )
    is also<draw-attributes>
  {
    my guint $m = resolve-uint($mode);
    my gint ($fv, $nv, $na) =
      resolve-int($first_vertex, $n_vertices, $n_attributes);

    cogl_framebuffer_draw_attributes(
      $!cf,
      $pipeline,
      $m,
      $fv,
      $nv,
      $attributes,
      $na
    );
  }

  method draw_indexed_attributes (
    CoglPipeline() $pipeline,
    Int() $mode,
    Int() $first_vertex,
    Int() $n_vertices,
    Pointer $indices,
    CArray[Pointer[CoglAttribute]] $attributes,
    Int() $n_attributes
  )
    is also<draw-indexed-attributes>
  {
    my guint $m = resolve-uint($mode);
    my gint ($fv, $nv, $na) =
      resolve-int($first_vertex, $n_vertices, $n_attributes);

    cogl_framebuffer_draw_indexed_attributes(
      $!cf,
      $pipeline,
      $m,
      $fv,
      $nv,
      $indices,
      $attributes,
      $na
    );
  }

  method draw_multitextured_rectangle (
    CoglPipeline() $pipeline,
    Num() $x_1,
    Num() $y_1,
    Num() $x_2,
    Num() $y_2,
    CArray[gfloat] $tex_coords,
    Int() $tex_coords_len
  )
    is also<draw-multitextured-rectangle>
  {
    my gfloat ($x1, $y1, $x2, $y2) = ($x_1, $y_1, $x_2, $y_2);
    my gint $l = resolve-int($tex_coords_len);

    cogl_framebuffer_draw_multitextured_rectangle(
      $!cf,
      $pipeline,
      $x1,
      $y1,
      $x2,
      $y2,
      $tex_coords,
      $l
    );
  }

  method draw_primitive (CoglPipeline() $pipeline, CoglPrimitive() $primitive)
    is also<draw-primitive>
  {
    cogl_framebuffer_draw_primitive($!cf, $pipeline, $primitive);
  }

  method draw_rectangle (
    CoglPipeline() $pipeline,
    Num() $x_1,
    Num() $y_1,
    Num() $x_2,
    Num() $y_2
  )
    is also<draw-rectangle>
  {
    my gfloat ($x1, $y1, $x2, $y2) = ($x_1, $y_1, $x_2, $y_2);

    cogl_framebuffer_draw_rectangle($!cf, $pipeline, $x1, $y1, $x2, $y2);
  }

  method draw_textured_rectangle (
    CoglPipeline() $pipeline,
    Num() $x_1,
    Num() $y_1,
    Num() $x_2,
    Num() $y_2,
    Num() $s_1,
    Num() $t_1,
    Num() $s_2,
    Num() $t_2
  ) is also<draw-textured-rectangle> {
    my gfloat ($x1, $y1, $x2, $y2, $s1, $t1, $s2, $t2) =
      ($x_1, $y_1, $x_2, $y_2, $s_1, $t_1, $s_2, $t_2);

    cogl_framebuffer_draw_textured_rectangle(
      $!cf,
      $pipeline,
      $x1,
      $y1,
      $x2,
      $y2,
      $s1,
      $t1,
      $s2,
      $t2
    );
  }

  method error_quark(COGL::FrameBuffer:U:) is also<error-quark> {
    cogl_framebuffer_error_quark();
  }

  method finish {
    cogl_framebuffer_finish($!cf);
  }

  method frustum (
    Num() $left,
    Num() $right,
    Num() $bottom,
    Num() $top,
    Num() $z_near,
    Num() $z_far
  ) {
    my ($l, $r, $b, $t, $zn, $zf) =
      ($left, $right, $bottom, $top, $z_near, $z_far);

    cogl_framebuffer_frustum($!cf, $l, $r, $b, $t, $zn, $zf);
  }

  method get_alpha_bits is also<get-alpha-bits> {
    cogl_framebuffer_get_alpha_bits($!cf);
  }

  method get_aspect is also<get-aspect> {
    self.width / self.height;
  }

  method get_blue_bits is also<get-blue-bits> {
    cogl_framebuffer_get_blue_bits($!cf);
  }

  method get_context is also<get-context> {
    cogl_framebuffer_get_context($!cf);
  }

  method get_depth_bits is also<get-depth-bits> {
    cogl_framebuffer_get_depth_bits($!cf);
  }

  method get_depth_texture is also<get-depth-texture> {
    cogl_framebuffer_get_depth_texture($!cf);
  }

  method get_green_bits is also<get-green-bits> {
    cogl_framebuffer_get_green_bits($!cf);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_framebuffer_get_gtype, $n, $t );
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    cogl_framebuffer_get_height($!cf);
  }

  method get_is_stereo
    is also<
      get-is-stereo
      is-stereo
      is_stereo
    >
  {
    cogl_framebuffer_get_is_stereo($!cf);
  }

  proto method get_modelview_matrix (|)
    is also<get-modelview-matrix>
  { * }

  multi method get_modelview_matrix(:$raw = False) {
    my CoglMatrix $matrix .= new;
    samewith($matrix, :$raw);
  }
  multi method get_modelview_matrix (CoglMatrix() $matrix, :$raw = False) {
    cogl_framebuffer_get_modelview_matrix($!cf, $matrix);
    $raw ?? $matrix !! COGL::Matrix.new($matrix);
  }

  method get_projection_matrix (CoglMatrix() $matrix)
    is also<get-projection-matrix>
  {
    cogl_framebuffer_get_projection_matrix($!cf, $matrix);
  }

  method get_red_bits is also<get-red-bits> {
    cogl_framebuffer_get_red_bits($!cf);
  }

  method get_size is also<size> {
    (self.get-width, self.get-height);
  }

  method get_viewport4fv (Num() $viewport) is also<get-viewport4fv> {
    my gfloat $v = $viewport;

    cogl_framebuffer_get_viewport4fv($!cf, $viewport);
  }

  method get_viewport_height is also<get-viewport-height> {
    cogl_framebuffer_get_viewport_height($!cf);
  }

  method get_viewport_width is also<get-viewport-width> {
    cogl_framebuffer_get_viewport_width($!cf);
  }

  method get_viewport_x is also<get-viewport-x> {
    cogl_framebuffer_get_viewport_x($!cf);
  }

  method get_viewport_y is also<get-viewport-y> {
    cogl_framebuffer_get_viewport_y($!cf);
  }

  method get_width
    is also<
      get-width
      width
    >
  {
    cogl_framebuffer_get_width($!cf);
  }

  method identity_matrix is also<identity-matrix> {
    cogl_framebuffer_identity_matrix($!cf);
  }

  method orthographic (
    Num() $x_1,
    Num() $y_1,
    Num() $x_2,
    Num() $y_2,
    Num() $near,
    Num() $far
  ) {
    my gfloat ($x1, $y1, $x2, $y2, $n, $f) =
      ($x_1, $y_1, $x_2, $y_2, $near, $far);

    cogl_framebuffer_orthographic($!cf, $x1, $y1, $x2, $y2, $n, $f);
  }

  method perspective (
    Num() $fov_y,
    Num() $aspect,
    Num() $z_near,
    Num() $z_far
  ) {
    my ($f, $a, $zn, $zf) = ($fov_y, $aspect, $z_near, $z_far);

    cogl_framebuffer_perspective($!cf, $f, $a, $zn, $zf);
  }

  method pop_clip is also<pop-clip> {
    cogl_framebuffer_pop_clip($!cf);
  }

  method pop_matrix is also<pop-matrix> {
    cogl_framebuffer_pop_matrix($!cf);
  }

  method push_matrix is also<push-matrix> {
    cogl_framebuffer_push_matrix($!cf);
  }

  method push_primitive_clip (
    CoglPrimitive() $primitive,
    Num() $bounds_x1,
    Num() $bounds_y1,
    Num() $bounds_x2,
    Num() $bounds_y2
  )
    is also<push-primitive-clip>
  {
    my gfloat ($bx1, $by1, $bx2, $by2) =
      ($bounds_x1, $bounds_y1, $bounds_x2, $bounds_y2);

    cogl_framebuffer_push_primitive_clip(
      $!cf,
      $primitive,
      $bx1,
      $by1,
      $bx2,
      $by2
    );
  }

  method push_rectangle_clip (
    Num() $x_1,
    Num() $y_1,
    Num() $x_2,
    Num() $y_2
  )
    is also<push-rectangle-clip>
  {
    my gfloat ($x1, $y1, $x2, $y2) = ($x_1, $y_1, $x_2, $y_2);

    cogl_framebuffer_push_rectangle_clip($!cf, $x1, $y1, $x2, $y2);
  }


  method push_scissor_clip (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  )
    is also<push-scissor-clip>
  {
    my gint ($xx, $yy, $w, $h) = resolve-int($x, $y, $width, $height);

    cogl_framebuffer_push_scissor_clip($!cf, $xx, $yy, $w, $h);
  }

  method read_pixels (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height,
    Int() $format,
    CArray[uint8] $pixels
  )
    is also<read-pixels>
  {
    my gint ($xx, $yy, $w, $h) = resolve-int($x, $y, $width, $height);
    my guint $f = resolve-uint($format);

    cogl_framebuffer_read_pixels($!cf, $xx, $yy, $w, $h, $f, $pixels);
  }

  method read_pixels_into_bitmap (
    Int() $x,
    Int() $y,
    Int() $source,
    CoglBitmap() $bitmap
  )
    is also<read-pixels-into-bitmap>
  {
    my gint ($xx, $yy) = resolve-int($x, $y);
    my guint $s = resolve-uint($source);

    cogl_framebuffer_read_pixels_into_bitmap($!cf, $x, $y, $source, $bitmap);
  }

  method resolve_samples is also<resolve-samples> {
    cogl_framebuffer_resolve_samples($!cf);
  }

  method resolve_samples_region (
    Int() $x,
    Int() $y,
    Int() $width,
    Int() $height
  )
    is also<resolve-samples-region>
  {
    my gint ($xx, $yy, $w, $h) = resolve-int($x, $y, $width, $height);

    cogl_framebuffer_resolve_samples_region($!cf, $xx, $yy, $w, $h);
  }

  method rotate (Num() $angle, Num() $x, Num() $y, Num() $z) {
    my gfloat ($a, $xx, $yy, $zz) = ($angle, $x, $y, $z);

    cogl_framebuffer_rotate($!cf, $a, $xx, $yy, $zz);
  }

  method rotate_euler (CoglEuler() $euler) is also<rotate-euler> {
    cogl_framebuffer_rotate_euler($!cf, $euler);
  }

  method rotate_quaternion (CoglQuaternion() $quaternion)
    is also<rotate-quaternion>
  {
    cogl_framebuffer_rotate_quaternion($!cf, $quaternion);
  }

  method scale (Num() $x, Num() $y, Num() $z) {
    my gfloat ($xx, $yy, $zz) = ($x, $y, $z);

    cogl_framebuffer_scale($!cf, $xx, $yy, $zz);
  }

  method set_modelview_matrix (CoglMatrix() $matrix)
    is also<set-modelview-matrix>
  {
    cogl_framebuffer_set_modelview_matrix($!cf, $matrix);
  }

  method set_projection_matrix (CoglMatrix() $matrix)
    is also<set-projection-matrix>
  {
    cogl_framebuffer_set_projection_matrix($!cf, $matrix);
  }

  method set_viewport (Num() $x, Num() $y, Num() $width, Num() $height)
    is also<set-viewport>
  {
    my gfloat ($xx, $yy, $w, $h) = ($x, $y, $width, $height);

    cogl_framebuffer_set_viewport($!cf, $xx, $yy, $w, $h);
  }

  method transform (CoglMatrix() $matrix) {
    cogl_framebuffer_transform($!cf, $matrix);
  }

  method translate (Num() $x, Num() $y, Num() $z) {
    my gfloat ($xx, $yy, $zz) = ($x, $y, $z);

    cogl_framebuffer_translate($!cf, $xx, $yy, $zz);
  }

  # method clear (Int() $buffer_mask, CoglColor() $color) {
  #   my uint64 $bm = resolve-ulong($buffer_mask);
  #
  #   cogl_color_clear($!cf, $bm, $color)
  # }

  method clear4f (
    Int() $buffer-mask,
    Num() $red,
    Num() $green,
    Num() $blue,
    Num() $alpha
  ) {
    my uint64 $bm = resolve-ulong($buffer-mask);
    my gfloat ($r, $g, $b, $a) = ($red, $green, $blue, $alpha);

    cogl_framebuffer_clear4f($!cf, $bm, $r, $g, $b, $a);
  }

  method draw_rectangles (
    CoglPipeline() $pipeline,
    CArray[gfloat] $coordinates,
    Int() $n_rectangles
  )
    is also<draw-rectangles>
  {
    my guint $nr = resolve-uint($n_rectangles);

    cogl_framebuffer_draw_rectangles($!cf, $pipeline, $coordinates, $nr);
  }

  method draw_textured_rectangles (
    CoglPipeline() $pipeline,
    CArray[gfloat] $coordinates,
    Int() $n_rectangles
  )
    is also<draw-textured-rectangles>
  {
    my guint $nr = resolve-uint($n_rectangles);

    cogl_framebuffer_draw_textured_rectangles(
      $!cf,
      $pipeline,
      $coordinates,
      $nr
    );
  }

  method discard_buffers (Int() $buffer_mask)
    is also<discard-buffers>
  {
    my uint64 $bm = resolve-ulong($buffer_mask);

    cogl_framebuffer_discard_buffers($!cf, $bm);
  }

}
