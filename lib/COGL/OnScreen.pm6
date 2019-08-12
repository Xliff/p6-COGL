use v6.c;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::OnScreen;

use COGL::FrameBuffer;

our subset OnscreenAncestry of Mu
  where CoglOnscreen | FrameBufferAncestry;

class COGL::OnScreen is COGL::FrameBuffer {
  has CoglOnscreen $!co;

  submethod BUILD (:$onscreen) {

    given $onscreen {
      when OnscreenAncestry {
        my $to-parent;
        $!co = do {
          when CoglOnscreen {
            $to-parent = cast(CoglFrameBuffer, $_);
            $_;
          }
          default {
            $to-parent = $_;
            cast(CoglOnscreen, $_);
          }
        }
        self.setFrameBuffer($to-parent);
      }

      when COGL::OnScreen {
      }

      default {
      }

    }

  }

  method new (CoglContext() $context, Int() $width, Int() $height) {
    my gint ($w, $h) = resolve-int($width, $height);
    self.bless( onscreen => cogl_onscreen_new($context, $w, $h) )
  }

  method resizable is rw {
    Proxy.new(
      FETCH => sub ($) {
        so cogl_onscreen_get_resizable($!co);
      },
      STORE => sub ($, Int() $resizable is copy) {
        my gboolean $r = resolve-bool($resizable);
        cogl_onscreen_set_resizable($!co, $r);
      }
    );
  }

  method add_dirty_callback (
    &callback,
    gpointer $user_data                  = gpointer,
    CoglUserDataDestroyCallback $destroy = gpointer
  ) {
    cogl_onscreen_add_dirty_callback($!co, &callback, $user_data, $destroy);
  }

  method add_frame_callback (
    &callback,
    gpointer $user_data                  = gpointer,
    CoglUserDataDestroyCallback $destroy = gpointer
  ) {
    cogl_onscreen_add_frame_callback($!co, &callback, $user_data, $destroy);
  }

  method add_resize_callback (
    &callback,
    gpointer $user_data                  = gpointer,
    CoglUserDataDestroyCallback $destroy = gpointer
  ) {
    cogl_onscreen_add_resize_callback($!co, &callback, $user_data, $destroy);
  }

  # method add_swap_buffers_callback (
  #   &callback,
  #   gpointer $user_data
  # ) 
  #   is DEPRECATED<COGL::OnScreen.add_frame_callback>
  # {
  #   cogl_onscreen_add_swap_buffers_callback($!co, &callback, $user_data);
  # }

  method frame_closure_get_gtype {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_frame_closure_get_gtype, $n , $t );
  }

  method is_onscreen (COGL::OnScreen:U: gpointer $candidate) {
    cogl_is_onscreen($candidate);
  }

  method mir_get_surface {
    cogl_mir_onscreen_get_surface($!co);
  }

  method mir_resize (Int() $width, Int() $height) {
    my gint ($w, $h) = resolve-int($width, $height);
    cogl_mir_onscreen_resize($!co, $width, $height);
  }

  method wayland_get_shell_surface {
    cogl_wayland_onscreen_get_shell_surface($!co);
  }

  method wayland_get_surface {
    cogl_wayland_onscreen_get_surface($!co);
  }

  method wayland_resize (
    Int() $width,
    Int() $height,
    Int() $offset_x,
    Int() $offset_y
  ) {
    my gint ($w, $h, $ox, $oy) = 
      resolve-int($width, $height, $offset_x, $offset_y);
      
    cogl_wayland_onscreen_resize($!co, $w, $h, $ox, $oy);
  }

  method win32_get_window {
    cogl_win32_onscreen_get_window($!co);
  }

  method win32_set_foreign_window (HWND $hwnd) {
    cogl_win32_onscreen_set_foreign_window($!co, $hwnd);
  }

  method x11_get_visual_xid {
    cogl_x11_onscreen_get_visual_xid($!co);
  }

  method x11_get_window_xid {
    cogl_x11_onscreen_get_window_xid($!co);
  }

  method x11_set_foreign_window_xid (
    Int() $xid,
    CoglOnscreenX11MaskCallback $update,
    gpointer $user_data = gpointer
  ) {
    my $xxid = resolve-uint($xid);
    cogl_x11_onscreen_set_foreign_window_xid($!co, $xxid, $update, $user_data);
  }

  method dirty_closure_get_gtype {
    state ($n, $t);
    unstable_get_type(
      self.^name,
      &cogl_onscreen_dirty_closure_get_gtype,
      $n,
      $t
    );
  }

  method get_buffer_age {
    cogl_onscreen_get_buffer_age($!co);
  }

  method get_frame_counter {
    cogl_onscreen_get_frame_counter($!co);
  }

  method get_gtype {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_onscreen_get_gtype, $n, $t );
  }

  method hide {
    cogl_onscreen_hide($!co);
  }

  method remove_dirty_callback (CoglOnscreenDirtyClosure $closure) {
    cogl_onscreen_remove_dirty_callback($!co, $closure);
  }

  method remove_frame_callback (CoglFrameClosure $closure) {
    cogl_onscreen_remove_frame_callback($!co, $closure);
  }

  method remove_resize_callback (CoglOnscreenResizeClosure $closure) {
    cogl_onscreen_remove_resize_callback($!co, $closure);
  }

  method resize_closure_get_gtype {
    state ($n, $t);
    unstable_get_type(
      self.^name,
      &cogl_onscreen_resize_closure_get_gtype,
      $n,
      $t
    );
  }

  method set_swap_throttled (Int() $throttled) {
    my gboolean $t = resolve-bool($throttled);
    cogl_onscreen_set_swap_throttled($!co, $t);
  }

  method show {
    cogl_onscreen_show($!co);
  }

  method swap_buffers {
    cogl_onscreen_swap_buffers($!co);
  }

  method swap_buffers_with_damage (Int() $rectangles, Int() $n_rectangles) {
    my gint ($r, $nr) = ($rectangles, $n_rectangles);
    
    cogl_onscreen_swap_buffers_with_damage($!co, $rectangles, $n_rectangles);
  }

  method swap_region (Int() $rectangles, Int() $n_rectangles) {
    cogl_onscreen_swap_region($!co, $rectangles, $n_rectangles);
  }

}
