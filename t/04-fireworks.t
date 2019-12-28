use v6.c;

# There will likely be no way around this at the end-user level.
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Timer;

use COGL::Raw::Types;

use COGL::Attribute;
use COGL::AttributeBuffer;
use COGL::Context;
use COGL::Onscreen;
use COGL::Pipeline;
use COGL::Primitive;
use COGL::Source;
use COGL::Texture2d;

use GLib::MainLoop;

use GTK::Compat::Roles::TypedBuffer;

use lib <. t>;

use Fireworks;

sub generate-round-texture($context) {
  my $p = CArray[uint8].allocate(TEXTURE_SIZE * TEXTURE_SIZE * 4);

  # You want more speed, you can NQP it!
  my $pos = 0;
  loop (my $x = 0; $x < TEXTURE_SIZE; $x++) {
    loop (my $y = 0; $y < TEXTURE_SIZE; $y++) {
      my $dx = $x - TEXTURE_SIZE / 2;
      my $dy = $y - TEXTURE_SIZE / 2;
      my gfloat $v  = (sqrt($dx * $dx * $dy * $dy) * 255 / TEXTURE_SIZE / 2).Num;

      $v = 255e0 if $v > 255;
      $v = 255e0 - $v;
      $p[$pos++] = $v.Int;
      $p[$pos++] = $v.Int;
      $p[$pos++] = $v.Int;
      $p[$pos++] = $v.Int;
    }
  }

  my $tex = COGL::Texture2d.new_from_data(
    $context,
    TEXTURE_SIZE, TEXTURE_SIZE,
    COGL_PIXEL_FORMAT_RGBA_8888_PRE,
    TEXTURE_SIZE * 4,
    $p
  );

  $tex;
}

sub paint (%data) {
  my gfloat $diff-time;
  my gint $i;

  loop ($i = 0; $i < N_FIREWORKS; $i++) {
    my $firework := %data<fireworks>[$i];

    if abs($firework.x - $firework.start-x) > 2e0 || $firework.y < 1e0 {
      $firework.size = (0.001e0 ..^ 0.1e0).rand;
      $firework.start-x = 1e0 + $firework.size;
      $firework.start-y = -1e0;
      $firework.initial-x-velocity = (-2e0 ^.. -0.1e0).rand;
      $firework.initial-y-velocity = (0.1e0 ..^ 4e0).rand;
      $firework.timer.reset();

      my $c-idx = (^3).pick;
      my $b = Bool.pick;
      memset($firework.color.p, $b ?? 255 !! 0, nativesizeof(Color));
      $firework.color.red   = $b ?? 0 !! 255 if $c-idx == 0;
      $firework.color.green = $b ?? 0 !! 255 if $c-idx == 1;
      $firework.color.blue  = $b ?? 0 !! 255 if $c-idx == 2;
      $firework.color.alpha = 255;

      # Fire some of the fireworks from the other side
      if Bool.pick {
        $firework.start-x = -$firework.start-x;
        $firework.initial-x-velocity = -$firework.initial-x-velocity;
      }
    }

    $diff-time = %data<last-spark-time>.elapsed;

    $firework.x = $firework.start-x +
                  $firework.initial-x-velocity * $diff-time;

    $firework.y = $firework.start-y +
                  $firework.initial-y-velocity * $diff-time +
                  0.5 * GRAVITY * $diff-time * $diff-time;
  }

  $diff-time = %data<last-spark-time>.elapsed;
  if $diff-time < 0 || $diff-time > TIME_PER_SPARK {
    loop ($i = 0; $i < N_FIREWORKS; $i++) {
      my $spark := %data<sparks>[%data<next-spark-num>];
      my $firework := %data<fireworks>[$i];

      $spark.x =
        $firework.x + (-$firework.size/2e0 ..^ $firework.size/2e0).rand;
      $spark.y =
        $firework.y + (-$firework.size/2e0 ..^ $firework.size/2e0).rand;

      $spark.base-color = $firework.color;

      %data<next-spark-num> = %data<next-spark-num> +& (N_SPARKS - 1);
    }

    # Update the colour of each spark
    loop (my gint $i = 0; $i < N_SPARKS; $i++) {
      my $spark := %data<sparks>[
        %data<next-spark-num> + $i +& (N_SPARKS - 1)
      ];

      my gfloat $cv = $i / (N_SPARKS - 1e0);
      $spark.base-color.red   = $spark.base-color.red * $cv;
      $spark.base-color.green = $spark.base-color.green * $cv;
      $spark.base-color.blue  = $spark.base-color.blue * $cv;
      $spark.base-color.alpha = 255e0 * $cv;
    }

    %data<last-spark-time>.reset();
  }

  %data<attribute-buffer>.set_data(
    0,
    %data<sparks>.p,
    %data<sparks>.bufferSize
  );

  %data<fb>.clear4f(COGL_BUFFER_BIT_COLOR, 0, 0, 0, 1);
  %data<primitive>.draw(%data<fb>, %data<pipeline>);
  %data<fb>.swap_buffers;
}

sub create-primitive (%data) {
  %data<attribute-buffer> = COGL::AttributeBuffer.new_with_size(
    %data<context>, %data<sparks>.bufferSize
  );
  %data<attribute-buffer>.update_hint = COGL_BUFFER_UPDATE_HINT_DYNAMIC;

  my $attributes = CArray[CoglAttribute].new;
  $attributes[0] = COGL::Attribute.new(
    %data<attribute-buffer>,
    'cogl_position_in',
    nativesizeof(Spark),
    0,                                # Position of 'x' in Spark
    2,                                # Number of components in position: (x, y)
    COGL_ATTRIBUTE_TYPE_FLOAT         # Type of each component
  ).CoglAttribute;

  $attributes[1] = COGL::Attribute.new(
    %data<attribute-buffer>,
    'cogl_color_in',
    nativesizeof(Spark),
    8,                                # Position of 'color' in Spark
    4,                                # Number of components in color: (r, g, b, a)
    COGL_ATTRIBUTE_TYPE_UNSIGNED_BYTE  # Type of each component
  ).CoglAttribute;

  %data<primitive> = COGL::Primitive.new_with_attributes(
    COGL_VERTICES_MODE_POINTS,
    N_SPARKS,
    $attributes,
    2
  );

  COGL::Object.unref( $attributes[$_] ) for (0, 1);
}

sub MAIN {
  my $frame_cb = 0;
  my %data;

  %data<fireworks> = GTK::Compat::Roles::TypedBuffer[Firework].new(
    size => N_FIREWORKS
  );
  %data<sparks>    = GTK::Compat::Roles::TypedBuffer[Spark].new(
    size => N_SPARKS
  );

  %data<context> = COGL::Context.new;
  create-primitive(%data);

  %data<pipeline> = COGL::Pipeline.new(%data<context>);
  %data<last-spark-time> = GTK::Compat::Timer.new;
  %data<next-spark-num> = 0;
  %data<pipeline>.point_size = TEXTURE_SIZE;

  my $tex = generate-round-texture(%data<context>);
  %data<pipeline>.set_layer_texture(0, $tex);
  $tex.unref;

  %data<pipeline>.set_layer_point_sprite_coords_enabled(0, True);

  my gint $i;
  loop ($i = 0; $i < N_FIREWORKS; $i++) {
    %data<fireworks>.bind($i, Firework.new);
    %data<fireworks>[$i].x     = -FLT_MAX;
    %data<fireworks>[$i].y     = FLT_MAX;
    %data<fireworks>[$i].size  = 0e0;
    %data<fireworks>[$i].timer = GTK::Compat::Timer.new;
  }
  loop ($i = 0; $i < N_SPARKS; $i++) {
    %data<sparks>.bind($i, Spark.new);
    %data<sparks>[$i].x = %data<sparks>[$i].y = 2e0;
  }

  %data<fb> = COGL::Onscreen.new(%data<context>, 800, 600);
  %data<fb>.show;
  %data<fb>.add_frame_callback(-> *@a {
    # CoglOnscreen, CoglFrameEvent, CoglFrameInfo, Pointer
    if CoglFrameEvent( @a[1] ) == COGL_FRAME_EVENT_SYNC {
      paint(%data);
      $frame_cb++;
    }
  });

  my $source = COGL::Source.new(%data<context>);
  $source.attach;

  my $loop = GLib::MainLoop.new(GMainContext, True);
  paint(%data);

  my $lock = Lock.new;
  $*SCHEDULER.cue({
    say "{ $frame_cb } calls made this second.";
    $lock.protect({ $frame_cb = 0 });
  }, every => 1);

  $loop.run;
  $loop.unref;

  %data{$_}.unref for <pipeline attribute_buffer primative fb context>;
  %data<last-spark-time>.destroy;
  %data<fireworks>[$_].destroy for ^N_FIREWORKS;
}
