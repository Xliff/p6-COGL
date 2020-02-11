use v6.c;

use Method::Also;
use NativeCall;

use GTK::Raw::Utils;


use COGL::Raw::Types;
use COGL::Raw::Context;

use COGL::Display;
use COGL::Object;
use COGL::Renderer;

our subset ContextAncestry is export of Mu
  where CoglContext | CoglObject;

class COGL::Context is COGL::Object {
  has CoglContext $!cc;

  submethod BUILD (:$context) {
    given $context {
      when ContextAncestry {
        my $to-parent;
        $!cc = do {
          when CoglContext {
            $to-parent = cast(CoglObject, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(CoglContext, $_);
          }
        }
        self.setObject($to-parent);
      }

      when COGL::Context {
      }

      default {
      }
    }
  }

  method COGL::Raw::Types::CoglContext
    is also<CoglContext>
  { $!cc }

  multi method new {
    samewith(CoglDisplay);
  }
  multi method new (
    CoglDisplay() $display,
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    clear_error;
    my $rc = cogl_context_new($display, $error);
    set_error($error);
    self.bless( context => $rc );
  }

  method foreach_feature (
    &callback,
    Pointer $user_data = Pointer
  )
    is also<foreach-feature>
  {
    cogl_foreach_feature($!cc, &callback, $user_data);
  }

  method get_clock_time
    is also<
      get-clock-time
      clock_time
      clock-time
    >
  {
    cogl_get_clock_time($!cc);
  }

  method has_feature (Int() $feature) is also<has-feature> {
    my guint $f = resolve-uint($feature);
    so cogl_has_feature($!cc, $f);
  }

  method is_context (COGL::Context:U: gpointer $candidate)
    is also<is-context>
  {
    so cogl_is_context($candidate);
  }

  method get_display (:$raw = False)
    is also<
      get-display
      display
    >
  {
    my $d = cogl_context_get_display($!cc);
    $d ??
      ( $raw ?? $d !! COGL::Display.new($d) )
      !!
      Nil;
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_context_get_gtype, $n, $t );
  }

  method get_renderer (:$raw = False)
    is also<
      get-renderer
      renderer
    >
  {
    my $r = cogl_context_get_renderer($!cc);
    $r ??
      ( $raw ?? $r !! COGL::Renderer.new($r) )
      !!
      Nil;
  }

}
