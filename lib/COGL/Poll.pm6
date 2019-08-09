use v6.c;

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
    CArray[Pointer[CoglPollFD]] $poll_fds, Int() $n_poll_fds
  ) {
    my gint $nfds = resolve-int($n_poll_fds);
    cogl_poll_renderer_dispatch($!cp, $poll_fds, $n_poll_fds);
  }

  method renderer_get_info (
    COGL::Poll:U:
    CArray[Pointer[CoglPollFD]] $poll_fds, Int() $n_poll_fds, Int() $timeout
  ) {
    my gint $nfds = resolve-int($n_poll_fds);
    my gint64 $t = resolve-int64($timeout)
    cogl_poll_renderer_get_info($!cp, $poll_fds, $nfds, $t);
  }
  
}

sub cogl_poll_renderer_dispatch (CoglRenderer $renderer, CoglPollFD $poll_fds, gint $n_poll_fds)
  is native(cogl)
  is export
{ * }

sub cogl_poll_renderer_get_info (CoglRenderer $renderer, CoglPollFD $poll_fds, gint $n_poll_fds, gint64_t $timeout)
  returns int
  is native(cogl)
  is export
{ * }