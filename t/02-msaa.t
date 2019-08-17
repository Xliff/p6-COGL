use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

use GTK::Compat::MainLoop;

use COGL::Context;
use COGL::Display;
use COGL::Offscreen;
use COGL::Onscreen;
use COGL::Pipeline;
use COGL::Poll;
use COGL::Primitive;
use COGL::Texture2d;

use GTK::Compat::Roles::TypedBuffer;

sub MAIN {
  my $v = 0;
  my $vertices = GTK::Compat::Roles::TypedBuffer[CoglVertexP2C4].new(
    size => 3
  );
  $vertices.bind( $v++, CoglVertexP2C4.new( |$_ ) ) for
    [   0,  0.7, 0xff, 0x00, 0x00, 0xff],
    [-0.7, -0.7, 0x00, 0xff, 0x00, 0xff],
    [ 0.7, -0.7, 0x00, 0x00, 0xff, 0xff];

  my $onscreen_template = COGL::OnscreenTemplate.new;
  $onscreen_template.samples-per-pixel = 4;

  my $display = COGL::Display.new($onscreen_template);
  unless $display.setup {
    say "Platform doesn't support onscreen 4x msaa rendering: {
         $ERROR.message }";
    exit 1;
  }

  unless ( my $ctx = COGL::Context.new($display) ) {
    say "Failed to create context: { $ERROR.message }";
    exit 1;
  }

  my $onscreen = COGL::Onscreen.new($ctx, 640, 480);
  $onscreen.samples-per-pixel = 4;
  unless $onscreen.allocate {
    say "Failed to allocate 4x msaa offscreen framebuffer, disabling msaa for onscreen rendering:";
    $ERROR.message.say;
    exit 1;
  }

  $onscreen.show;

  my $tex = COGL::Texture2d.new-with-size($ctx, 320, 480);
  my $offscreen = COGL::Offscreen.new-with-texture($tex);
  $offscreen.samples-per-pixel = 4;
  unless $offscreen.allocate {
    say "Failed to allocate 4x msaa offscreen framebuffer, disabling msaa for offscreen rendering:";
    $ERROR.message.say;
    $offscreen.samples-per-pixel = 0;
  }

  my $triangle = COGL::Primitive.new-p2c4(
    $ctx,
    COGL_VERTICES_MODE_TRIANGLES,
    3,
    $vertices.p
  );
  my $pipeline = COGL::Pipeline.new($ctx);

  loop {
    use NativeCall;

    $onscreen.clear4f(COGL_BUFFER_BIT_COLOR, 0, 0, 0, 1);
    $onscreen.push_matrix;
    $onscreen.scale(0.5, 1, 1);
    $onscreen.translate(-1, 0, 0);
    $triangle.draw($onscreen, $pipeline);
    $offscreen.resolve-samples;

    my $texture-pipeline = COGL::Pipeline.new($ctx);
    $texture-pipeline.set-layer-texture(0, $tex);
    $onscreen.draw-rectangle($texture-pipeline, 0, 1, 1, -1);
    $texture-pipeline.unref;
    $onscreen.swap-buffers;

    my ($poll_fds, $n_poll_fds, $timeout) =
      (CArray[Pointer[CoglPollFD]].new, 0, 0);

    $poll_fds[0] = Pointer[CoglPollFD].new;
    COGL::Poll.get-info($ctx.get-renderer, $poll_fds, $n_poll_fds, $timeout);
    GTK::Compat::MainLoop.poll(
      cast(Pointer, $poll_fds),
      $n_poll_fds,
      $timeout == -1 ?? -1 !! $timeout / 1000
    );
    COGL::Poll.dispatch($ctx.get-renderer, $poll_fds[0], $n_poll_fds);
  }
}