use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Renderer;

class COGL::Renderer {
  has CoglRenderer $!cr;

  submethod BUILD (:$renderer) {
    $!cr = $renderer;
  }

  method new {
    self.bless( renderer => cogl_renderer_new() );
  }

  method driver is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglDriver( cogl_renderer_get_driver($!cr) );
      },
      STORE => sub ($, Int() $driver is copy) {
        my guint $d = resolve-uint($driver);
        cogl_renderer_set_driver($!cr, $d);
      }
    );
  }

  method winsys_id is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglWinsysID( cogl_renderer_get_winsys_id($!cr) );
      },
      STORE => sub ($, Int() $winsys_id is copy) {
        my guint $w = resolve-uint($winsys_id);
        cogl_renderer_set_winsys_id($!cr, $w);
      }
    );
  }

  method add_constraint (Int() $constraint) {
    my guint $c = resolve-uint($constraint);
    cogl_renderer_add_constraint($!cr, $c);
  }

  method check_onscreen_template (
    CoglOnscreenTemplate $onscreen_template,
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    clear_error;
    my $rc = cogl_renderer_check_onscreen_template(
      $!cr,
      $onscreen_template,
      $error
    );
    set_error($error);
    $rc;
  }

  method is_renderer (gpointer $object) {
    cogl_is_renderer($object);
  }

  method connect (CArray[Pointer[CoglError]] $error = gerror) {
    clear_error;
    my $rc = cogl_renderer_connect($!cr, $error);
    set_error($error);
    $rc;
  }

  method error_quark {
    cogl_renderer_error_quark();
  }

  method foreach_output (
    CoglOutputCallback $callback,
    gpointer $user_data = Pointer
  ) {
    cogl_renderer_foreach_output($!cr, $callback, $user_data);
  }

  method get_gtype {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_renderer_get_gtype, $n, $t );
  }

  method get_n_fragment_texture_units {
    cogl_renderer_get_n_fragment_texture_units($!cr);
  }

  method remove_constraint (Int() $constraint) {
    my guint $c = resolve-uint($constraint);
    cogl_renderer_remove_constraint($!cr, $c);
  }

}
