use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

use COGL::Context;
use COGL::Display;
use COGL::Renderer;

my (%data, %features);
INIT {
  %data{ .name } = .contents[0].contents.subst(/\s+/, ' ') for @( $=pod );

  %features = (

=begin basic
The hardware supports non power of two textures, but you also
need to check the COGL_FEATURE_ID_TEXTURE_NPOT_MIPMAP and
COGL_FEATURE_ID_TEXTURE_NPOT_REPEAT features to know if the
hardware supports npot texture mipmaps or repeat modes other
than COGL_RENDERER_PIPELINE_WRAP_MODE_CLAMP_TO_EDGE respectively.
=end basic

    COGL_FEATURE_ID_TEXTURE_NPOT_BASIC => {
      short => 'Non power of two textures (basic)',
      long  => %data<basic>
    },

=begin mipmap
Mipmapping is supported in conjuntion with non power of two
textures.
=end mipmap

    COGL_FEATURE_ID_TEXTURE_NPOT_MIPMAP => {
      short => 'Non power of two textures (+ mipmap)',
      long  => %data<mipmap>
    },

=begin repeat
Repeat modes other than
COGL_RENDERER_PIPELINE_WRAP_MODE_CLAMP_TO_EDGE are supported by
the hardware in conjunction with non power of two textures.
=end repeat

    COGL_FEATURE_ID_TEXTURE_NPOT_REPEAT => {
      short => 'Non power of two textures (+ repeat modes)',
      long  => %data<repeat>
    },

=begin npot
Non power of two textures are supported by the hardware. This
is a equivalent to the COGL_FEATURE_ID_TEXTURE_NPOT_BASIC,
COGL_FEATURE_ID_TEXTURE_NPOT_MIPMAP and
COGL_FEATURE_ID_TEXTURE_NPOT_REPEAT features combined.
=end npot

    COGL_FEATURE_ID_TEXTURE_NPOT => {
      short => 'Non power of two textures (fully featured)',
      long  => %data<npot>
    },

=begin rectangle
Support for rectangular textures with non-normalized texture
coordinates.
=end rectangle

    COGL_FEATURE_ID_TEXTURE_RECTANGLE => {
      short => 'Unnormalized coordinate, rectangle textures',
      long  => %data<rectangle>
    },

    COGL_FEATURE_ID_TEXTURE_3D => {
      short => '3D texture support',
      long  => '3D texture support'
    },

    COGL_FEATURE_ID_OFFSCREEN => {
      short => 'Offscreen rendering support',
      long  => 'Offscreen rendering support'
    },

    COGL_FEATURE_ID_OFFSCREEN_MULTISAMPLE => {
      short => 'Offscreen rendering with multisampling support',
      long  => 'Offscreen rendering with multisampling support',
    },

    COGL_FEATURE_ID_ONSCREEN_MULTIPLE => {
      short => 'Multiple onscreen framebuffers supported',
      long  => 'Multiple onscreen framebuffers supported'
    },

    COGL_FEATURE_ID_GLSL => {
      short => 'GLSL support',
      long  => 'GLSL support'
    },

=begin int_indices
COGL_RENDERER_INDICES_TYPE_UNSIGNED_INT is
supported in cogl_indices_new().
=end int_indices

    COGL_FEATURE_ID_UNSIGNED_INT_INDICES => {
      short => 'Unsigned integer indices',
      long  => %data<int_indices>
    },

    COGL_FEATURE_ID_DEPTH_RANGE => {
      short => 'cogl_pipeline_set_depth_range() support',
      long  => 'cogl_pipeline_set_depth_range() support'
    },

=begin point_sprite
cogl_pipeline_set_layer_point_sprite_coords_enabled()
is supported
=end point_sprite

    COGL_FEATURE_ID_POINT_SPRITE => {
      short => 'Point sprite coordinates',
      long  => %data<point_sprite>
    },

    COGL_FEATURE_ID_MAP_BUFFER_FOR_READ => {
      short => 'Mapping buffers for reading',
      long  => 'Mapping buffers for reading'
    },

    COGL_FEATURE_ID_MAP_BUFFER_FOR_WRITE => {
      short => 'Mapping buffers for writing',
      long  => 'Mapping buffers for writing'
    },

    COGL_FEATURE_ID_MIRRORED_REPEAT => {
      short => 'Mirrored repeat wrap modes',
      long  => 'Mirrored repeat wrap modes'
    },

=begin gles2_context
Support for creating a GLES2 context for using the
GLES2 API in a way that's integrated with Cogl.
=end gles2_context

    COGL_FEATURE_ID_GLES2_CONTEXT => {
      short => 'GLES2 API integration supported',
      long  => %data<gles2_context>
    },

=begin depth_texture
CoglFramebuffers can be configured to render their depth buffer
into a texture.
=end depth_texture

    COGL_FEATURE_ID_DEPTH_TEXTURE => {
      short => 'Depth Textures',
      long  => %data<depth_texture>
    },

=begin point_size
cogl_point_size_in can be used as an attribute to specify a
per-vertex point size
=end point_size

    COGL_FEATURE_ID_PER_VERTEX_POINT_SIZE => {
      short => 'Per-vertex point size',
      long  => %data<point_size>
    },

  );

}

sub get_winsys_name_for_id ($winsys_id) {
  do given $winsys_id {
    when COGL_WINSYS_ID_ANY         { 'ERROR'                             }
    when COGL_WINSYS_ID_STUB        { 'Stub'                              }
    when COGL_WINSYS_ID_GLX         { 'GLX'                               }
    when COGL_WINSYS_ID_EGL_XLIB    { 'EGL + Xlib platform'               }
    when COGL_WINSYS_ID_EGL_NULL    { 'EGL + NULL window system platform' }
    when COGL_WINSYS_ID_EGL_GDL     { 'EGL + GDL platform'                }
    when COGL_WINSYS_ID_EGL_WAYLAND { 'EGL + Wayland platform'            }
    when COGL_WINSYS_ID_EGL_KMS     { 'EGL + KMS platform'                }
    when COGL_WINSYS_ID_EGL_ANDROID { 'EGL + Android platform'            }
    when COGL_WINSYS_ID_WGL         { 'EGL + Windows WGL platform'        }
    when COGL_WINSYS_ID_SDL         { 'EGL + SDL platform'                }

    default                         { 'Unknown' }
  }
}

sub output-cb ($r, $s is rw) {
  state $outputNo = 0;

  my @v = $r.subpixel-order.Str.split('_');
  @v = @v[*-1] eq <RGB BGR>.any ?? @v[* - 2, * - 1] !! @v[* - 1];
  my $so = @v.join(',').lc;

  my $ref = $r.refresh_rate;
  $ref = $ref ?? "$ref Hz" !! 'unknown';

  say qq:to/OUTPUT/;
   Output{ $outputNo++ }:
    » Position        = { $r.x }, { $r.y }
    » Resolution      = { $r.width } x { $r.height }
    » Physical Size   = { $r.mm-width }mm x { $r.mm-height }mm
    » Sub pixel order = { $so }
    » Refresh         = { $ref }
  OUTPUT
}

sub MAIN {
  unless (my $ctx = COGL::Context.new) {
    say "Failed to create context: { $ERROR.message }";
    exit 1;
  }

  my $state-id    = 0;
  my $display     = $ctx.display;
  my $renderer    = $display.renderer;
  my $winsys-id   = $renderer.winsys-id;
  my $winsys-name = get_winsys_name_for_id($winsys-id);

  say "Renderer: { $winsys-name }";
  $ctx.foreach-feature(-> $f, $u {
    CATCH { default { .message.say } }
    say " » { %features{ CoglFeatureID($f).Str }<short> //
              "unknown feature { $f }" }";
  });

  say "\nOutputs:";
  $renderer.foreach-output(-> $o, $u { output-cb($renderer, $state-id) });
  say ' Unknown' if $state-id = 0;
}
