use v6.c;

use COGL::Raw::Types;
# Because Xliff doesn't want to put Pango defs in COGL::Raw::Types...
use Pango::Raw::Definitions;
use Pango::Raw::Subs;

use Pango::FontDescription;
use Pango::Layout;

use GLib::MainLoop;
use GLib::Timer;

use COGL::Color;
use COGL::Context;
use COGL::DepthState;
use COGL::FontMap;
use COGL::FrameBuffer;
use COGL::Indices;
use COGL::Matrix;
use COGL::Onscreen;
use COGL::Pango;
use COGL::Pipeline;
use COGL::Poll;
use COGL::Primitive;
use COGL::Source;
use COGL::Texture2d;

use GLib::Roles::TypedBuffer;

constant COGL_EXAMPLES_DATA = '.';

my @v = (
  # Front face
  [ -1.0, -1.0, 1.0, 0.0, 1.0 ],
  [  1.0, -1.0, 1.0, 1.0, 1.0 ],
  [  1.0,  1.0, 1.0, 1.0, 0.0 ],
  [ -1.0,  1.0, 1.0, 0.0, 0.0 ],

  # Back face
  [ -1.0, -1.0, -1.0, 1.0, 0.0 ],
  [ -1.0,  1.0, -1.0, 1.0, 1.0 ],
  [  1.0,  1.0, -1.0, 0.0, 1.0 ],
  [  1.0, -1.0, -1.0, 0.0, 0.0 ],

  # Top face
  [ -1.0,  1.0, -1.0, 0.0, 1.0 ],
  [ -1.0,  1.0,  1.0, 0.0, 0.0 ],
  [  1.0,  1.0,  1.0, 1.0, 0.0 ],
  [  1.0,  1.0, -1.0, 1.0, 1.0 ],

  # Bottom face
  [ -1.0, -1.0, -1.0, 1.0, 1.0 ],
  [  1.0, -1.0, -1.0, 0.0, 1.0 ],
  [  1.0, -1.0,  1.0, 0.0, 0.0 ],
  [ -1.0, -1.0,  1.0, 1.0, 0.0 ],

  # Right face
  [ 1.0, -1.0, -1.0, 1.0, 0.0 ],
  [ 1.0,  1.0, -1.0, 1.0, 1.0 ],
  [ 1.0,  1.0,  1.0, 0.0, 1.0 ],
  [ 1.0, -1.0,  1.0, 0.0, 0.0 ],

  # Left face
  [ -1.0, -1.0, -1.0, 0.0, 0.0 ],
  [ -1.0, -1.0,  1.0, 1.0, 0.0 ],
  [ -1.0,  1.0,  1.0, 1.0, 1.0 ],
  [ -1.0,  1.0, -1.0, 0.0, 1.0 ]
);

my $vertices;

sub paint(%d) {
  CATCH { default { .message.say } }

  with %d<fb> {
    .clear4f(COGL_BUFFER_BIT_COLOR +| COGL_BUFFER_BIT_DEPTH, 0, 0, 0, 1);
    .push-matrix;
    .translate(%d<framebuffer-width> / 2, %d<framebuffer-height> / 2, 0);
    .scale(75, 75, 75);

    # Update the rotation based on the time the application has been
    # running so that we get a linear animation regardless of the frame
    # rate
    my $rotation = %d<timer>.elapsed * 60;

    # Rotate the cube separately around each axis.
    #
    # Note: Cogl matrix manipulation follows the same rules as for
    # OpenGL. We use column-major matrices and - if you consider the
    # transformations happening to the model - then they are combined
    # in reverse order which is why the rotation is done last, since
    # we want it to be a rotation around the origin, before it is
    # scaled and translated.
    .rotate($rotation, 0, 0, 1);
    .rotate($rotation, 0, 1, 0);
    .rotate($rotation, 1, 0, 0);

    %d<prim>.draw($_, %d<crate-pipeline>);
    .pop-matrix;

    # And finally render our Pango layouts...
    # say qq:to/D/;
    #   { $_ }
    #   { %d<hello-label> }
    #   { (%d<framebuffer-width> / 2)  - (%d<hello-label-width>  / 2) }
    #   { (%d<framebuffer-height> / 2) - (%d<hello-label-height> / 2) }
    #   D

    COGL::Pango.show-layout(
      $_,
      %d<hello-label>,
      (%d<framebuffer-width> / 2)  - (%d<hello-label-width>  / 2),
      (%d<framebuffer-height> / 2) - (%d<hello-label-height> / 2),
      %d<white>
    )
  }

  %d<frames>++;
}

sub MAIN {
  my %data;

  $vertices = GLib::Roles::TypedBuffer[CoglVertexP3T2].new(
    size => @v.elems
  );
  for @v.kv -> $k, $v {
    $vertices.bind( $k, CoglVertexP3T2.new( |$v ) );
  }

  %data<ctx> = COGL::Context.new;
  unless %data<ctx> {
    say "Failed to create context: { $ERROR.message }";
    exit 1;
  }

  with %data {
    .<fb> = COGL::Onscreen.new(.<ctx>, 640, 480);
    .<framebuffer-width framebuffer-height> = .<fb>.size;

    .<timer> = GLib::Timer.new;
    .<fb>.show;
    .<fb>.set-viewport(0, 0, |.<fb>.size);

    my ($fovy, $aspect, $z-near, $z_2d, $z-far) =
      (60, .<fb>.get-aspect, 0.1, 1000, 2000);

    .<fb>.perspective($fovy, $aspect, $z-near, $z-far);

    # Since the pango renderer emits geometry in pixel/device coordinates
    # and the anti aliasing is implemented with the assumption that the
    # geometry *really* does end up pixel aligned, we setup a modelview
    # matrix so that for geometry in the plane z = 0 we exactly map x
    # coordinates in the range [0, stage_width] and y coordinates in the
    # range [0,stage_height] to the framebuffer extents with (0,0) being
    # the top left.
    #
    # This is roughly what Clutter does for a ClutterStage, but this
    # demonstrates how it is done manually using Cogl

    .<view> = COGL::Matrix.new(:identity);
    .<view>.view_2d_in_perspective(
      $fovy,
      $aspect,
      $z-near,
      $z_2d,
      |.<fb>.size
    );
    .<fb>.modelview-matrix = .<view>;
    .<white> = COGL::Color.new.init_from_4ub(0xff, 0xff, 0xff, 0xff);

    # rectangle indices allow the GPU to interpret a list of quads (the
    # faces of our cube) as a list of triangles.
    #
    # Since this is a very common thing to do
    # cogl_get_rectangle_indices() is a convenience function for
    # accessing internal index buffers that can be shared.
    .<indices> = COGL::Indices.get-rectangle-indices( .<ctx>, 6, :raw );
    .<prim> = COGL::Primitive.new-p3t2(
      .<ctx>,
      COGL_VERTICES_MODE_TRIANGLES,
      @v.elems,
      $vertices.p
    );

    # Each face will have 6 indices so we have 6 * 6 indices in total...
    .<prim>.set-indices(.<indices>.p, 6 * 6);

    # Load a jpeg crate texture from a file
    say "crate.jpg (CC by-nc-nd http://bit.ly/9kP45T) ShadowRunner27 http://bit.ly/m1YXLh\n";
    my $texture = COGL_EXAMPLES_DATA.IO.add('crate.jpg');
    $texture = COGL_EXAMPLES_DATA.IO.add('t').add('crate.jpg')
      unless $texture.IO.e;
    die "Cannot find texture file `{ $texture.path }`!" unless $texture.IO.e;
    .<texture> = COGL::Texture2d.new-from-file( .<ctx>, $texture );
    unless .<texture> {
      say "Failed to load texture: { $ERROR.message }";
      exit 1;
    }

    # a CoglPipeline conceptually describes all the state for vertex
    # * processing, fragment processing and blending geometry. When
    # * drawing the geometry for the crate this pipeline says to sample a
    # * single texture during fragment processing...
    .<crate-pipeline> = COGL::Pipeline.new( .<ctx> );
    .<crate-pipeline>.set-layer-texture( 0, .<texture> );

    # Since the box is made of multiple triangles that will overlap
    # * when drawn and we don't control the order they are drawn in, we
    # * enable depth testing to make sure that triangles that shouldn't
    # * be visible get culled by the GPU.
    my $depth-state = COGL::DepthState.new;
    $depth-state.test-enabled = True;
    .<crate-pipeline>.set-depth-state($depth-state);

    # Setup a Pango font map and context
    .<font-map> = COGL::FontMap.new( .<ctx> );
    .<font-map>.use-mipmapping = True;
    .<pango-context> = .<font-map>.create-context;
    .<font-desc> = Pango::FontDescription.new;
    ( .<font-desc>.family, .<font-desc>.size ) = ('Sans', 30 * PANGO_SCALE);

    # Setup the "Hello Cogl" text
    .<hello-label> = Pango::Layout.new( .<pango-context> );
    .<hello-label>.font-description = .<font-desc>;
    .<hello-label>.text = 'Hello Cogl';
    my ($, $ls) = .<hello-label>.get-extents;
    ( .<hello-label-width>, .<hello-label-height> ) =
      ($ls.width, $ls.height).map({ PANGO_PIXELS($_) });
    .<swap-ready> = True;

    say "{ .<framebuffer-width> }x{ .<framebuffer-height> }";
    say ( .<hello-label-width>, .<hello-label-height> );

    .<fb>.add-frame-callback(-> *@a {
      .<swap-ready> = True
        if CoglFrameEventEnum( @a[1] ) == COGL_FRAME_EVENT_SYNC;
    });

    my $lock = Lock.new;
    $*SCHEDULER.cue(in => 1, every => 1, {
      say "FPS: { .<frames> }";
      $lock.protect: { .<frames> = 0 }
    });
  }

  %data<frames> = 0;
  loop {
    state $f = False;
    use NativeCall;

    if %data<swap-ready> {
      paint(%data);
      %data<fb>.swap-buffers;
    }

    my ($poll_fds, $n_poll_fds, $timeout) =
      (CArray[Pointer[CoglPollFD]].new, 0, 0);
    $poll_fds[0] = Pointer[CoglPollFD].new;

    my $renderer = %data<ctx>.renderer;
    COGL::Poll.get-info($renderer, $poll_fds, $n_poll_fds, $timeout);
    GLib::MainLoop.poll(
      $poll_fds[0],
      $n_poll_fds,
      $timeout == -1 ?? -1 !! $timeout / 1000
    );
    COGL::Poll.dispatch($renderer, $poll_fds[0], $n_poll_fds);
  }

}
