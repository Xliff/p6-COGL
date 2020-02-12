use v6.c;

use Method::Also;

use COGL::Raw::Types;
use COGL::Raw::Offscreen;

use COGL::FrameBuffer;

our subset OffscreenAncestry is export of Mu
  where CoglOffscreen | FrameBufferAncestry;

class COGL::Offscreen is COGL::FrameBuffer {
  has CoglOffscreen $!co;

  submethod BUILD (:$offscreen) {
    given $offscreen {
      when OffscreenAncestry {
        my $to-parent;
        $!co = do {
          when CoglOffscreen {
            $to-parent = cast(CoglFrameBuffer, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(CoglOffscreen, $_);
          }
        }
        self.setFrameBuffer($to-parent);
      }

      when COGL::Offscreen {
      }

      default {
      }
    }
  }

  method COGL::Raw::Definitions::CoglOffscreen
    is also<CoglOffscreen>
  { $!co }

  multi method new (CoglOffscreen $offscreen) {
    $offscreen ?? self.bless(:$offscreen) !! Nil;
  }
  multi method new (
    CoglTexture() $texture,
    :to_texture(:to-texture(:$to)) is required
  ) {
    COGL::Offscreen.new_to_texture($texture);
  }
  multi method new (
    CoglTexture() $texture,
    :with_texture(:with-texture(:$with)) is required
  ) {
    COGL::Offscreen.new_with_texture($texture);
  }

  method new_to_texture (CoglTexture() $texture)
    is DEPRECATED<COGL::Offscreen.new_with_texture>
    is also<new-to-texture>
  {
    my $offscreen = cogl_offscreen_new_to_texture($texture);

    $offscreen ?? self.bless(:$offscreen) !! Nil;
  }

  method new_with_texture (CoglTexture() $texture)
    is also<new-with-texture>
  {
    my $offscreen = cogl_offscreen_new_with_texture($texture);

    $offscreen ?? self.bless(:$offscreen) !! Nil;
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
