use v6.c;

use Method::Also;

use COGL::Raw::Types;
use COGL::Raw::OnscreenTemplate;

use COGL::SwapChain;

class COGL::OnscreenTemplate {
  has CoglOnscreenTemplate $!cot;
  has %!attr;

  submethod BUILD (:$template) {
    $!cot = $template;
  }

  method COGL::Raw::Definitions::CoglOnscreenTemplate
    is also<CoglOnscreenTemplate>
  { $!cot }

  multi method new (CoglOnscreenTemplate $template) {
    $template ?? self.bless(:$template) !! Nil;
  }
  multi method new (CoglSwapChain $sc = CoglSwapChain) {
    my $template = cogl_onscreen_template_new($sc);

    $template ?? self.bless(:$template) !! Nil;
  }
  multi method new (COGL::SwapChain $sc) {
    return Nil unless $sc;

    samewith($sc.CoglSwapChain);
  }

  proto method is_onscreen_template (|)
    is also<is-onscreen-template>
  { * }

  multi method is_onscreen_template {
    samewith($!cot.p);
  }
  multi method is_onscreen_template (gpointer $candidate) {
    so cogl_is_onscreen_template($candidate);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_onscreen_template_get_gtype, $n, $t );
  }

  method set_samples_per_pixel (Int() $n) is also<set-samples-per-pixel> {
    my gint $nn = %!attr<samples-perl-pixel> = $n;

    cogl_onscreen_template_set_samples_per_pixel($!cot, $nn);
  }

  method set_stereo_enabled (Int() $enabled) is also<set-stereo-enabled> {
    my gboolean $e = %!attr<stereo-enabled> = $enabled.so.Int;

    cogl_onscreen_template_set_stereo_enabled($!cot, $e);
  }

  method set_swap_throttled (CoglBool $throttled) is also<set-swap-throttled> {
    my gboolean $t = %!attr<swap-throttled> = $throttled.so.Int;

    cogl_onscreen_template_set_swap_throttled($!cot, $t);
  }

  method samples_per_pixel is rw is also<samples-per-pixel> {
    Proxy.new:
      FETCH => sub ($)           { %!attr<samples-per-pixel> },
      STORE => -> $, Int() $n { self.set-samples-per-pixel($n) };
  }

  method stereo_enabled is rw is also<stereo-enabled> {
    Proxy.new:
      FETCH => sub ($)           { %!attr<stereo-enabled> },
      STORE => -> $, Int() $e { self.set-stereo-enabled($e) };
  }

  method swap_throttled is rw is also<swap-throttled> {
    Proxy.new:
      FETCH => sub ($)           { %!attr<swap-throttled> },
      STORE => -> $, Int() $t { self.set-swap-throttled($t) };
  }

}
