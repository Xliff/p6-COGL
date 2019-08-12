use v6.c;

use NativeCall;
use Method::Also;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;

use GTK::Compat::Raw::Main;

use GTK::Compat::Source;

class COGL::Source is GTK::Compat::Source {
  has CoglSource $!cs;
  
  submethod BUILD (CoglSource :$coglsource) {
    self.setSource( cast(GSource, $!cs = $coglsource) );
  }
  
  method COGL::Raw::Types::CoglSource 
    is also<CoglSource>
  { $!cs }
  
  method renderer_source_new (CoglRenderer() $renderer, Int() $priority = 0) 
    is also<renderer-source-new>
  {
    my gint $p = resolve-int($priority);
    
    self.bless(
      coglsource => cogl_glib_renderer_source_new($renderer, $priority)
    );
  }

  method new (CoglContext() $context, Int() $priority = 0) {
    my gint $p = resolve-int($priority);
    my $coglsource = cogl_glib_source_new($context, $priority);
    
    self.bless( :$coglsource );
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
