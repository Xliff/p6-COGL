use v6.c;

use NativeCall;


use Pango::Raw::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Pango;

sub cogl_pango_ensure_glyph_cache_for_layout (PangoLayout $layout)
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_font_map_clear_glyph_cache (CoglPangoFontMap $font_map)
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_font_map_create_context (CoglPangoFontMap $font_map)
  returns PangoContext
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_font_map_get_renderer (CoglPangoFontMap $font_map)
  returns PangoRenderer
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_font_map_get_use_mipmapping (CoglPangoFontMap $font_map)
  returns CoglBool
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_font_map_new (CoglContext $context)
  returns CoglPangoFontMap
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_font_map_set_resolution (
  CoglPangoFontMap $font_map, 
  gdouble $dpi
)
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_font_map_set_use_mipmapping (
  CoglPangoFontMap $font_map, 
  CoglBool $value
)
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_render_layout (
  PangoLayout $layout, 
  gint $x, 
  gint $y, 
  CoglColor $color, 
  gint $flags
)
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_render_layout_line (
  PangoLayoutLine $line, 
  gint $x, 
  gint $y, 
  CoglColor $color
)
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_render_layout_subpixel (
  PangoLayout $layout, 
  gint $x, 
  gint $y, 
  CoglColor $color, 
  gint $flags
)
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_renderer_get_type ()
  returns GType
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_show_layout (
  CoglFrameBuffer $framebuffer, 
  PangoLayout $layout, 
  gfloat $x, 
  gfloat $y, 
  CoglColor $color
)
  is native(cogl-pango)
  is export
{ * }

sub cogl_pango_show_layout_line (
  CoglFrameBuffer $framebuffer, 
  PangoLayoutLine $line, 
  gfloat $x, 
  gfloat $y, 
  CoglColor $color
)
  is native(cogl-pango)
  is export
{ * }
