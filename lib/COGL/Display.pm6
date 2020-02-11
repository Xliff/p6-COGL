use v6.c;

use Method::Also;
use NativeCall;




use COGL::Raw::Types;
use COGL::Raw::Display;

use COGL::OnscreenTemplate;
use COGL::Renderer;

class COGL::Display {
  has CoglDisplay $!cd;

  submethod BUILD (:$display) {
    $!cd = $display;
  }

  method COGL::Raw::Types::CoglDisplay
    is also<CoglDisplay>
  { $!cd }

  multi method new (CoglDisplay $display) {
    self.bless( :$display );
  }
  multi method new (CoglRenderer $renderer) {
    samewith($renderer, CoglOnscreenTemplate);
  }
  multi method new (CoglOnscreenTemplate $template) {
    samewith(CoglRenderer, $template);
  }
  multi method new ($param is copy) {
    do given $param {
      when COGL::OnscreenTemplate { $param .= CoglOnscreenTemplate; proceed }
      when COGL::Renderer         { $param .= CoglRenderer;         proceed }
      when CoglOnscreenTemplate   { samewith(CoglRenderer, $_)              }
      when CoglRenderer           { samewith($_, CoglOnscreenTemplate)      }

      default {
        die "Invalid type passed to COGL::Display.new: { .^name }";
      }
    }
  }
  multi method new (
    CoglRenderer() $renderer,
    CoglOnscreenTemplate() $onscreen_template
  ) {
    self.bless( display => cogl_display_new($renderer, $onscreen_template) );
  }

  method gdl_display_set_plane (Int() $plane) is also<gdl-display-set-plane> {
    my guint $p = resolve-uint($plane);

    cogl_gdl_display_set_plane($!cd, $plane);
  }


  proto method is_display (|)
    is also<is-display>
  { * }

  multi method is_display {
    COGL::Display.is_display($!cd);
  }
  multi method is_display (COGL::Display:U: Pointer $candidate)  {
    so cogl_is_display($candidate);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_display_get_gtype, $n, $t );
  }

  method get_renderer (:$raw = False)
    is also<
      get-renderer
      renderer
    >
  {
    my $r = cogl_display_get_renderer($!cd);
    $r ??
      ( $raw ?? $r !! COGL::Renderer.new($r) )
      !!
      Nil;
  }

  method set_onscreen_template (CoglOnscreenTemplate() $onscreen_template)
    is also<set-onscreen-template>
  {
    cogl_display_set_onscreen_template($!cd, $onscreen_template);
  }

  method setup (CArray[Pointer[CoglError]] $error = gerror) {
    clear_error;
    my $rc = cogl_display_setup($!cd, $error);
    set_error($error);
    so $rc;
  }

}
