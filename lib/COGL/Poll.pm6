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
    Pointer $poll_fds,
    Int() $n_poll_fds
  )
    is also<
      renderer-dispatch
      dispatch
    >
  {
    my gint $nfds = resolve-int($n_poll_fds);
    
    cogl_poll_renderer_dispatch($renderer, $poll_fds, $n_poll_fds);
  }

  method renderer_get_info (
    COGL::Poll:U:
    CoglRenderer() $renderer,
    CArray[Pointer[CoglPollFD]] $poll_fds,
    Int() $n_poll_fds is rw,
    Int() $timeout is rw 
  )
    is also<
      renderer-get-info
      get_info
      get-info
    >
  {
    my gint $nfds = 0;
    my gint64 $t = 0;
    
    cogl_poll_renderer_get_info($renderer, $poll_fds, $nfds, $t);
    ($n_poll_fds, $timeout) = ($nfds, $t);
    ($poll_fds, $n_poll_fds, $timeout);
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
