use v6.c;

use NativeCall;

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
        self.setFramebuffer($to-parent);
      }

      when COGL::OnScreen {
      }

      default {
      }

    }

  }

  method new (CoglContext $context, gint $width, gint $height) {
    self.bless( onscreen => cogl_onscreen_new($context, $width, $height) )
  }

  method resizable is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_onscreen_get_resizable($!co);
      },
      STORE => sub ($, $resizable is copy) {
        cogl_onscreen_set_resizable($!co, $resizable);
      }
    );
  }

  method add_dirty_callback (
    CoglOnscreenDirtyCallback $callback,
    gpointer $user_data,
    CoglUserDataDestroyCallback $destroy
  ) {
    cogl_onscreen_add_dirty_callback($!co, $callback, $user_data, $destroy);
  }

  method add_frame_callback (
    CoglFrameCallback $callback,
    gpointer $user_data,
    CoglUserDataDestroyCallback $destroy
  ) {
    cogl_onscreen_add_frame_callback($!co, $callback, $user_data, $destroy);
  }

  method add_resize_callback (
    CoglOnscreenResizeCallback $callback,
    gpointer $user_data,
    CoglUserDataDestroyCallback $destroy
  ) {
    cogl_onscreen_add_resize_callback($!co, $callback, $user_data, $destroy);
  }

  method add_swap_buffers_callback (
    CoglSwapBuffersNotify $callback,
    gpointer $user_data
  ) {
    cogl_onscreen_add_swap_buffers_callback($!co, $callback, $user_data);
  }

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

  method mir_resize (gint $width, gint $height) {
    cogl_mir_onscreen_resize($!co, $width, $height);
  }

  method wayland_get_shell_surface {
    cogl_wayland_onscreen_get_shell_surface($!co);
  }

  method wayland_get_surface {
    cogl_wayland_onscreen_get_surface($!co);
  }

  method wayland_resize (
    gint $width,
    gint $height,
    gint $offset_x,
    gint $offset_y
  ) {
    cogl_wayland_onscreen_resize($!co, $width, $height, $offset_x, $offset_y);
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
    uint32 $xid,
    CoglOnscreenX11MaskCallback $update,
    gpointer $user_data
  ) {
    cogl_x11_onscreen_set_foreign_window_xid($!co, $xid, $update, $user_data);
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

  method set_swap_throttled (CoglBool $throttled) {
    cogl_onscreen_set_swap_throttled($!co, $throttled);
  }

  method show {
    cogl_onscreen_show($!co);
  }

  method swap_buffers {
    cogl_onscreen_swap_buffers($!co);
  }

  method swap_buffers_with_damage (gint $rectangles, gint $n_rectangles) {
    cogl_onscreen_swap_buffers_with_damage($!co, $rectangles, $n_rectangles);
  }

  method swap_region (gint $rectangles, gint $n_rectangles) {
    cogl_onscreen_swap_region($!co, $rectangles, $n_rectangles);
  }

}
