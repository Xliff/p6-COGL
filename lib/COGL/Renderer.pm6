use v6.c;

use Method::Also;
use NativeCall;




use COGL::Raw::Types;
use COGL::Raw::Renderer;

use COGL::Output;

our subset RendererAncestry is export of Mu
  where CoglRenderer | CoglOutput;

class COGL::Renderer is COGL::Output {
  has CoglRenderer $!cr;

  submethod BUILD (:$renderer) {
    given $renderer {
      when RendererAncestry {
        my $to-parent;

        $!cr = do {
          when CoglRenderer {
            $to-parent = cast(CoglOutput, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(CoglRenderer, $_);
          }
        };
        self.setOutput($to-parent);
      }

      when COGL::Renderer {
      }

      default {
      }
    }
  }

  method COGL::Raw::Types::CoglRenderer
    is also<CoglRenderer>
  { $!cr }

  multi method new (CoglRenderer $renderer) {
    self.bless( :$renderer );
  }
  multi method new {
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

  method winsys_id is rw is also<winsys-id> {
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

  method add_constraint (Int() $constraint) is also<add-constraint> {
    my guint $c = resolve-uint($constraint);
    cogl_renderer_add_constraint($!cr, $c);
  }

  method check_onscreen_template (
    CoglOnscreenTemplate $onscreen_template,
    CArray[Pointer[CoglError]] $error = gerror
  )
    is also<check-onscreen-template>
  {
    clear_error;
    my $rc = cogl_renderer_check_onscreen_template(
      $!cr,
      $onscreen_template,
      $error
    );
    set_error($error);
    $rc;
  }

  method is_renderer (gpointer $object) is also<is-renderer> {
    cogl_is_renderer($object);
  }

  method connect (CArray[Pointer[CoglError]] $error = gerror) {
    clear_error;
    my $rc = cogl_renderer_connect($!cr, $error);
    set_error($error);
    $rc;
  }

  method error_quark is also<error-quark> {
    cogl_renderer_error_quark();
  }

  method foreach_output (
    &callback,
    gpointer $user_data = Pointer
  )
    is also<foreach-output>
  {
    cogl_renderer_foreach_output($!cr, &callback, $user_data);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_renderer_get_gtype, $n, $t );
  }

  method get_n_fragment_texture_units is also<get-n-fragment-texture-units> {
    cogl_renderer_get_n_fragment_texture_units($!cr);
  }

  method remove_constraint (Int() $constraint) is also<remove-constraint> {
    my guint $c = resolve-uint($constraint);
    cogl_renderer_remove_constraint($!cr, $c);
  }

}
