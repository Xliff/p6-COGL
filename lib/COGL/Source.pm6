use v6.c;

use NativeCall;
use Method::Also;

use COGL::Raw::Types;
use GLib::Raw::Main;

use GLib::Source;

our subset CoglSourceAncestry is export of Mu
  where CoglSource | GSource;

class COGL::Source is GLib::Source {
  has CoglSource $!cs;

  submethod BUILD (:$coglsource) {
    given $coglsource {
      when CoglSourceAncestry { self.setCoglSource($coglsource) }
      when COGL::Source       { }
      default                 { }
    }
  }

  method setCoglSource (CoglSourceAncestry $_) {
    my $to-parent;
    $!cs = do {
      when CoglSource {
        $to-parent = cast(GSource, $_);
        $_;
      }

      default {
        $to-parent = $_;
        cast(CoglSource, $_);
      }
    }
    self.setSource($to-parent);
  }

  method COGL::Raw::Definitions::CoglSource
    is also<CoglSource>
  { $!cs }

  method renderer_source_new (CoglRenderer() $renderer, Int() $priority = 0)
    is also<renderer-source-new>
  {
    my gint $p = $priority;
    my $coglsource = cogl_glib_renderer_source_new($renderer, $priority);

    $coglsource ?? self.bless( :$coglsource ) !! Nil;
  }

  proto method new (|)
  { * }

  multi method new (CoglSourceAncestry $coglsource) {
    $coglsource ?? self.bless( :$coglsource ) !! Nil
  }
  multi method new (CoglContext() $context, Int() $priority = 0) {
    my gint $p = $priority;
    my $coglsource = cogl_glib_source_new($context, $priority);

    $coglsource ?? self.bless( :$coglsource ) !! Nil;
  }

}

sub cogl_glib_renderer_source_new (CoglRenderer $renderer, gint $priority)
  returns CoglSource
  is native(cogl)
  is export
{ * }

sub cogl_glib_source_new (CoglContext $context, gint $priority)
  returns CoglSource
  is native(cogl)
  is export
{ * }
