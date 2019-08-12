use v6.c;

use Method::Also;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Offscreen;

use COGL::Object;

our subset OffscreenAncestry is export of Mu
  where CoglOffscreen | CoglObject;

class COGL::Offscreen is COGL::Object {
  has CoglOffscreen $!co;

  submethod BUILD (:$offscreen) {
    given $offscreen {
      when OffscreenAncestry {
        my $to-parent;
        $!co = do {
          when CoglOffscreen {
            $to-parent = cast(CoglObject, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(CoglOffscreen, $_);
          }
        }
        self.setObject($to-parent);
      }

      when COGL::Offscreen {
      }

      default {
      }
    }
  }

  method new_to_texture (CoglTexture() $texture)
    is DEPRECATED<COGL::Offscreen.new_with_texture>
    is also<new-to-texture>
  {
    self.bless( offscreen => cogl_offscreen_new_to_texture($texture) );
  }

  method new_with_texture (CoglTexture() $texture)
    is also<new-with-texture>
  {
    self.bless( offscreen => cogl_offscreen_new_with_texture($texture) );
  }

  method is_offscreen (COGL::Offscreen:U: gpointer $candidate)
    is also<is-offscreen>
  {
    so cogl_is_offscreen($candidate);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_offscreen_get_gtype, $n, $t );
  }

  method ref {
    cogl_offscreen_ref($!co);
    self;
  }

  method unref {
    cogl_offscreen_unref($!co);
  }

}
