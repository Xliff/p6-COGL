use v6.c;

use Method::Also;

use NativeCall;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;

class COGL::Poll {

  method new (|) {
    warn 'COGL::Poll is a static class and does not need to be instantiated!'
      if $DEBUG;
    COGL::Poll;
  }

  method renderer_dispatch (
    COGL::Poll:U:
    CoglRenderer() $renderer,
    CArray[Pointer[CoglPollFD]] $poll_fds,
    Int() $n_poll_fds
  )
    is also<renderer-dispatch>
  {
    my gint $nfds = resolve-int($n_poll_fds);
    cogl_poll_renderer_dispatch($renderer, $poll_fds, $n_poll_fds);
  }

  method renderer_get_info (
    COGL::Poll:U:
    CoglRenderer() $renderer,
    CArray[Pointer[CoglPollFD]] $poll_fds,
    Int() $n_poll_fds,
    Int() $timeout
  )
    is also<renderer-get-info>
  {
    my gint $nfds = resolve-int($n_poll_fds);
    my gint64 $t = resolve-int64($timeout);
    cogl_poll_renderer_get_info($renderer, $poll_fds, $nfds, $t);
  }

}

sub cogl_poll_renderer_dispatch (
  CoglRenderer $renderer,
  CoglPollFD $poll_fds,
  gint $n_poll_fds
)
  is native(cogl)
  is export
{ * }

sub cogl_poll_renderer_get_info (
  CoglRenderer $renderer,
  CoglPollFD $poll_fds,
  gint $n_poll_fds,
  gint64 $timeout
)
  returns gint
  is native(cogl)
  is export
{ * }
