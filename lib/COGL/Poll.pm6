use v6.c;

use Method::Also;
use NativeCall;

use COGL::Raw::Types;

use GLib::Roles::StaticClass;

class COGL::Poll {
  also does GLib::Roles::StaticClass;

  method renderer_dispatch (
    CoglRenderer() $renderer,
    Pointer $poll_fds,
    Int() $n_poll_fds
  )
    is also<
      renderer-dispatch
      dispatch
    >
  {
    my gint $nfds = $n_poll_fds;

    cogl_poll_renderer_dispatch($renderer, $poll_fds, $n_poll_fds);
  }

  proto method renderer_get_info (|)
    is also<
      renderer-get-info
      get_info
      get-info
    >
  { * }

  multi method renderer_get_info(
    CoglRenderer() $renderer,
    CArray[Pointer[CoglPollFD]] $poll_fds,
  ) {
    samewith($renderer, $poll_fds, $, $);
  }
  multi method renderer_get_info (
    CoglRenderer() $renderer,
    CArray[Pointer[CoglPollFD]] $poll_fds,
    Int() $n_poll_fds is rw,
    Int() $timeout is rw
  ) {
    my gint $nfds = 0;
    my gint64 $t = 0;

    cogl_poll_renderer_get_info($renderer, $poll_fds, $nfds, $t);
    ($n_poll_fds, $timeout) = ($nfds, $t);
  }

}

sub cogl_poll_renderer_dispatch (
  CoglRenderer $renderer,
  Pointer $poll_fds,
  gint $n_poll_fds
)
  is native(cogl)
  is export
{ * }

sub cogl_poll_renderer_get_info (
  CoglRenderer $renderer,
  CArray[Pointer[CoglPollFD]] $poll_fds,
  gint $n_poll_fds is rw,
  gint64 $timeout is rw
)
  returns gint
  is native(cogl)
  is export
{ * }
