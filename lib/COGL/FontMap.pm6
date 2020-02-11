use v6.c;

use Method::Also;


use Pango::Raw::Types;
use COGL::Raw::Types;
use COGL::Raw::Pango;



use Pango::FontMap;

our subset CoglFontMapAncestry is export of Mu
  where CoglPangoFontMap | PangoFontMap;

class COGL::FontMap is Pango::FontMap {
  has CoglPangoFontMap $!cf;
  
  method BUILD (:$coglfontmap) {
    given $coglfontmap {
      
      when CoglFontMapAncestry {
        my $to-parent;
        $!cf = do {
          when CoglPangoFontMap {
            $to-parent = cast(PangoFontMap, $_);
            $_;
          }
          
          default {
            $to-parent = $_;
            cast(CoglPangoFontMap, $_);
          }
        };
        self.setFontMap($to-parent);
      }
    
      when COGL::FontMap {
      }
      
      default {
      }
    }
  }
  
  method new (CoglContext() $context) {
    self.bless( coglfontmap => cogl_pango_font_map_new($context) );
  }

  method clear_glyph_cache is also<clear-glyph-cache> {
    cogl_pango_font_map_clear_glyph_cache($!cf);
  }

  method create_context (:$raw = False) is also<create-context> {
    my $c = cogl_pango_font_map_create_context($!cf);
    $c ??
      ( $raw ?? $c !! Pango::Context.new($c) )
      !!
      Nil;
  }

  method get_renderer (:$raw = False) is also<get-renderer> {
    my $r = cogl_pango_font_map_get_renderer($!cf);
    $r ??
      ( $raw ?? $r !! Pango::Renderer.new($r) )
      !! 
      Nil;
  }

  method get_use_mipmapping is also<get-use-mipmapping> {
    so cogl_pango_font_map_get_use_mipmapping($!cf);
  }

  method set_resolution (Num() $dpi) is also<set-resolution> {
    my gdouble $ddpi = $dpi;
    
    cogl_pango_font_map_set_resolution($!cf, $ddpi);
  }

  method set_use_mipmapping (Int() $value) is also<set-use-mipmapping> {
    my gboolean $v = resolve-bool($value);
    
    cogl_pango_font_map_set_use_mipmapping($!cf, $v);
  }
  
  method use_mipmapping is also<use-mipmapping> is rw {
    Proxy.new: 
      FETCH => -> $           { self.get-use-mipmapping },
      STORE => -> $, Int() $v { self.set-use-mipmapping($v) };
  }
  
}
