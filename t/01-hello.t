use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

use GLib::MainLoop;

use COGL::Onscreen;
use COGL::Context;
use COGL::Pipeline;
use COGL::Primitive;
use COGL::Source;

use GTK::Compat::Roles::TypedBuffer;

sub MAIN {
  my %data;
  my $triangle-verticies = GTK::Compat::Roles::TypedBuffer[CoglVertexP2C4].new(
    size => 3
  );
  $triangle-verticies.bind( $_[0], CoglVertexP2C4.new( |$_[1 .. *-1] ) ) for (
    [0,    0,  0.7, 0xff, 0x00, 0x00, 0xff],
    [1, -0.7, -0.7, 0x00, 0xff, 0x00, 0xff],
    [2,  0.7, -0.7, 0x00, 0x00, 0xff, 0xff]
  );

  %data<redraw-idle> = 0;
  %data<is-dirty>    = False;
  %data<draw-ready>  = True;

  %data<ctx> = COGL::Context.new;
  unless %data<ctx>.defined {
    say "Failed to create context: { $ERROR.message }";
    exit 1;
  }

  %data<fb> = COGL::Onscreen.new(%data<ctx>, 640, 480);
  %data<fb>.show;
  %data<fb>.resizable = True;

  %data<triangle> = COGL::Primitive.new_p2c4(
    %data<ctx>,
    COGL_VERTICES_MODE_TRIANGLES,
    3,
    $triangle-verticies.p
  );

  %data<pipeline> = COGL::Pipeline.new(%data<ctx>);

  my $source = COGL::Source.new(%data<ctx>);
  $source.attach;

  my &maybe-redraw = sub {
    %data<redraw-idle> = COGL::Source.idle_add(-> *@a --> gboolean {
      %data<redraw-idle> = 0;
      %data<is-dirty> = %data<draw-ready> = False;
      %data<fb>.clear4f(COGL_BUFFER_BIT_COLOR, 0, 0, 0, 1);
      %data<triangle>.draw(%data<fb>, %data<pipeline>);
      %data<fb>.swap-buffers;
      G_SOURCE_REMOVE;
    }) if %data<is-dirty> && %data<draw-ready> && %data<redraw-idle> == 0;
  };

  %data<fb>.add-frame-callback(-> *@a {
    if CoglFrameEvent( @a[1] ) == COGL_FRAME_EVENT_SYNC {
      %data<draw-ready> = True;
      maybe-redraw;
    }
  });
  %data<fb>.add-dirty-callback(-> *@a {
    %data<is-dirty> = True;
    maybe-redraw;
  });

  my $loop = GLib::MainLoop.new(GMainContext, True);
  $loop.run;
}
