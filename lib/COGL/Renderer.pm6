use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Renderer;

class COGL::Renderer {
  has CoglRenderer $!cr;
  
  method new {
    cogl_renderer_new();
  }
  
  method driver is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_renderer_get_driver($!cr);
      },
      STORE => sub ($, $driver is copy) {
        cogl_renderer_set_driver($!cr, $driver);
      }
    );
  }

  method winsys_id is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_renderer_get_winsys_id($!cr);
      },
      STORE => sub ($, $winsys_id is copy) {
        cogl_renderer_set_winsys_id($!cr, $winsys_id);
      }
    );
  }

  method add_constraint (CoglRendererConstraint $constraint) {
    cogl_renderer_add_constraint($!cr, $constraint);
  }

  method check_onscreen_template (
    CoglOnscreenTemplate $onscreen_template, 
    CArray[Pointer[CoglError]] $error = gerror
  ) {
    cogl_renderer_check_onscreen_template($!cr, $onscreen_template, $error);
  }

  method cogl_is_renderer {
    cogl_is_renderer($!cr);
  }

  method connect (CArray[Pointer[CoglError]] = gerror $error) {
    cogl_renderer_connect($!cr, $error);
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
    cogl_renderer_get_gtype($!cr);
  }

  method get_n_fragment_texture_units {
    cogl_renderer_get_n_fragment_texture_units($!cr);
  }

  method remove_constraint (CoglRendererConstraint $constraint) {
    cogl_renderer_remove_constraint($!cr, $constraint);
  }
  
}
