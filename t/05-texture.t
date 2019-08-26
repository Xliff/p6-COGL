use v6.c;
# Ported from:
# https://github.com/tpimh/vala-cogl/blob/master/cogl-texture/cogl-texture.vala
use GTK::Compat::Types;
use COGL::Raw::Types;

use GTK::Compat::MainLoop;
use GTK::Compat::Roles::TypedBuffer;

use COGL::Context;
use COGL::Color;
use COGL::Onscreen;
use COGL::Pipeline;
use COGL::Primitive;
use COGL::Source;
use COGL::Texture2d;

constant COGL_EXAMPLES_DATA = '.';

my %data;
my @p = (
  CoglVertexP2T2.new(-1, -1, 0, 1),
  CoglVertexP2T2.new( 1, -1, 1, 1),
  CoglVertexP2T2.new( 1,  1, 1, 0),
  CoglVertexP2T2.new(-1,  1, 0, 0)
);
my $picture-vertices = GTK::Compat::Roles::TypedBuffer[CoglVertexP2T2].new(@p);

sub maybe-redraw {
  if %data<is-dirty> && %data<draw-ready> && %data<redraw-idle> == 0 {
    %data<redraw-idle> = COGL::Source.idle_add(-> *@a --> gboolean {
      %data<redraw-idle> = 0;
      %data<is-dirty draw-ready> = False xx 2;
      with %data<fb> {
        .push-matrix;
        .clear(COGL_BUFFER_BIT_COLOR, %data<background>);
        .scale( %data<scale-x>, %data<scale-y>, 0 );
        %data<picture>.draw($_, %data<pipeline>);
        .pop-matrix;
        .swap-buffers;
      }
      G_SOURCE_REMOVE;
    });
  }
}

sub err($msg) { $msg.say; exit 1 }

sub MAIN {
  %data<redraw-idle scale-x scale-y> = (0, 1, 1);
  %data<is-dirty> = False;
  %data<draw-ready> = True;

  err("Failed to create context: { $ERROR.message }")
    unless %data<ctx> = COGL::Context.new;

  %data<fb> = COGL::Onscreen.new(%data<ctx>, 512, 512);
  %data<fb>.show;
  %data<fb>.resizable = True;
  %data<background> = COGL::Color.new.init_from_4f(0.4, 0.6, 0.9, 0);

  my $texture = COGL_EXAMPLES_DATA.IO.add('tex256.png');
  $texture = COGL_EXAMPLES_DATA.IO.add('t').add('tex256.png')
    unless $texture.IO.e;
  die "Cannot find texture file `{ $texture.path }`!" unless $texture.IO.e;
  err("Failed to load texture: { $ERROR.message }")
    unless %data<texture> = COGL::Texture2d.new_from_file(%data<ctx>, $texture);

  %data<picture> = COGL::Primitive.new-p2t2(
    %data<ctx>,
    COGL_VERTICES_MODE_TRIANGLE_FAN,
    $picture-vertices
  );
  %data<pipeline> = COGL::Pipeline.new(%data<ctx>);
  %data<pipeline>.set-layer-texture(0, %data<texture>);
  %data<source> = COGL::Source.new(%data<ctx>);
  %data<source>.attach;

  with %data<fb> {
    .add-frame-callback(-> *@a {
      if CoglFrameEvent( @a[1] ) == COGL_FRAME_EVENT_SYNC {
        %data<draw-ready> = True;
        maybe-redraw;
      }
    });

    .add-dirty-callback(-> *@a {
      %data<is-dirty> = True;
      maybe-redraw;
    });

    .add-resize-callback(-> *@a {
      say "resize { @a[1] }x{ @a[2] }";
      %data<scale-x> = 256e0 / @a[1];
      %data<scale-y> = 256e0 / @a[2];
    });
  }
  my $loop = GTK::Compat::MainLoop.new(GMainContext, True);
  $loop.run;
}
