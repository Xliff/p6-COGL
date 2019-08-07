use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::OnScreen;

sub cogl_onscreen_add_dirty_callback (
  CoglOnscreen $onscreen, 
  CoglOnscreenDirtyCallback $callback, 
  Pointer $user_data, 
  CoglUserDataDestroyCallback $destroy
)
  returns CoglOnscreenDirtyClosure
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_add_frame_callback (
  CoglOnscreen $onscreen, 
  CoglFrameCallback $callback, 
  Pointer $user_data, 
  CoglUserDataDestroyCallback $destroy
)
  returns CoglFrameClosure
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_add_resize_callback (
  CoglOnscreen $onscreen, 
  CoglOnscreenResizeCallback $callback, 
  Pointetr $user_data, 
  CoglUserDataDestroyCallback $destroy
)
  returns CoglOnscreenResizeClosure
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_add_swap_buffers_callback (
  CoglOnscreen $onscreen, 
  CoglSwapBuffersNotify $callback, 
  Pointer $user_data
)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_frame_closure_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_is_onscreen (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_mir_onscreen_get_surface (CoglOnscreen $onscreen)
  returns MirSurface
  is native(cogl)
  is export
{ * }

sub cogl_mir_onscreen_resize (
  CoglOnscreen $onscreen, 
  gint $width, 
  gint $height
)
  is native(cogl)
  is export
{ * }

sub cogl_wayland_onscreen_get_shell_surface (CoglOnscreen $onscreen)
  returns wl_shell_surface
  is native(cogl)
  is export
{ * }

sub cogl_wayland_onscreen_get_surface (CoglOnscreen $onscreen)
  returns wl_surface
  is native(cogl)
  is export
{ * }

sub cogl_wayland_onscreen_resize (
  CoglOnscreen $onscreen, 
  gint $width, 
  gint $height, 
  gint $offset_x, 
  gint $offset_y
)
  is native(cogl)
  is export
{ * }

sub cogl_win32_onscreen_get_window (CoglOnscreen $onscreen)
  returns HWND
  is native(cogl)
  is export
{ * }

sub cogl_win32_onscreen_set_foreign_window (CoglOnscreen $onscreen, HWND $hwnd)
  is native(cogl)
  is export
{ * }

sub cogl_x11_onscreen_get_visual_xid (CoglOnscreen $onscreen)
  returns uint32_t
  is native(cogl)
  is export
{ * }

sub cogl_x11_onscreen_get_window_xid (CoglOnscreen $onscreen)
  returns uint32_t
  is native(cogl)
  is export
{ * }

sub cogl_x11_onscreen_set_foreign_window_xid (
  CoglOnscreen $onscreen, 
  uint32_t $xid, 
  CoglOnscreenX11MaskCallback $update, 
  Pointer $user_data
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_dirty_closure_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_get_buffer_age (CoglOnscreen $onscreen)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_get_frame_counter (CoglOnscreen $onscreen)
  returns int64_t
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_hide (CoglOnscreen $onscreen)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_new (CoglContext $context, gint $width, gint $height)
  returns CoglOnscreen
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_remove_dirty_callback (
  CoglOnscreen $onscreen, 
  CoglOnscreenDirtyClosure $closure
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_remove_frame_callback (
  CoglOnscreen $onscreen, 
  CoglFrameClosure $closure
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_remove_resize_callback (
  CoglOnscreen $onscreen, 
  CoglOnscreenResizeClosure $closure
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_resize_closure_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_set_swap_throttled (
  CoglOnscreen $onscreen, 
  CoglBool $throttled
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_show (CoglOnscreen $onscreen)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_swap_buffers (CoglOnscreen $onscreen)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_swap_buffers_with_damage (
  CoglOnscreen $onscreen, 
  gint $rectangles, 
  gint $n_rectangles
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_swap_region (
  CoglOnscreen $onscreen, 
  gint $rectangles, 
  gint $n_rectangles
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_get_resizable (CoglOnscreen $onscreen)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_set_resizable (CoglOnscreen $onscreen, CoglBool $resizable)
  is native(cogl)
  is export
{ * }
