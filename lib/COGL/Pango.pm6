use v6.c;

use Method::Also;

use Pango::Raw::Definitions;
use COGL::Raw::Types;
use COGL::Raw::Pango;

use GLib::Roles::StaticClass;

class COGL::Pango {
  also does GLib::Roles::StaticClass;

  method ensure_glyph_cache_for_layout (PangoLayout() $layout) {
    cogl_pango_ensure_glyph_cache_for_layout($layout);
  }

  method render_layout (
    PangoLayout() $layout,
    Int() $x,
    Int() $y,
    CoglColor() $color,
    Int() $flags
  )
    is also<render-layout>
  {
    my gint ($xx, $yy, $ff) = $x, $y, $flags;

    cogl_pango_render_layout($layout, $xx, $yy, $color, $ff);
  }

  method render_layout_line (
    PangoLayoutLine() $line,
    Int() $x,
    Int() $y,
    CoglColor() $color
  )
    is also<render-layout-line>
  {
    my gint ($xx, $yy) = $x, $y;

    cogl_pango_render_layout_line($line, $xx, $yy, $color);
  }

  method render_layout_subpixel (
    PangoLayout() $layout,
    Int() $x,
    Int() $y,
    CoglColor() $color,
    Int() $flags
  )
    is also<render-layout-subpixel>
  {
    my gint ($xx, $yy, $ff) = $x, $y, $flags;

    cogl_pango_render_layout_subpixel($layout, $xx, $yy, $color, $ff);
  }

  method renderer_get_type is also<renderer-get-type> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_pango_renderer_get_type, $n, $t );
  }

  method show_layout (
    CoglFrameBuffer() $fb,
    PangoLayout() $layout,
    Num() $x,
    Num() $y,
    CoglColor() $color
  )
    is also<show-layout>
  {
    my gfloat ($xx, $yy) = ($x, $y);

    cogl_pango_show_layout($fb, $layout, $xx, $yy, $color);
  }

  method show_layout_line (
    CoglFrameBuffer() $fb,
    PangoLayoutLine() $line,
    Num() $x,
    Num() $y,
    CoglColor() $color
  )
    is also<show-layout-line>
  {
    my gfloat ($xx, $yy) = ($x, $y);

    cogl_pango_show_layout_line($fb, $line, $xx, $yy, $color);
  }

}
