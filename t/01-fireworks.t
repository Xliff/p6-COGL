use v6.c;

# There will likely be no way around this at the end-user level.
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Timer;

use COGL::Texture2d;

constant N_FIREWORKS    = 32;
constant TEXTURE_SIZE   = 32;
constant TIME_PER_SPARK = 0.1;
constant GRAVITY        = -1.5;
constant FLT_MAX        = 3.402823e38;   # C define value

class Color is repr('CStruct') {
  has uint8 $.red   is rw;
  has uint8 $.green is rw;
  has uint8 $.blue  is rw;
  has uint8 $.alpha is rw;
}

class Firework is repr('CStruct') {
  my $timer-attr = Firework.^attributes[* - 1];
  
  has gfloat $.size               is rw;
  has gfloat $.x                  is rw;
  has gfloat $.y                  is rw;
  has gfloat $.start-x            is rw;
  has gfloat $.start-y            is rw;
  has gfloat $.initial-x-velocity is rw;
  has gfloat $.initial-y-velocity is rw;
  
  HAS Color  $.color;
  
  has GTimer $!timer;
  
  method timer is rw {
    Proxy.new:
      FETCH => -> $ { $!timer },
      STORE => -> $, GTimer() \val { $timer-attr.set-value(self, val) };
  }
}

class Spark is repr('CStruct') {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  
  HAS Color  $.color;
  HAS Color  $.base-color;
}

sub generate-round-texture($context) {
  my $p = CArray[gfloat].allocate(TEXTURE_SIZE * TEXTURE_SIZE * 4);
  
  # You want more speed, you can NQP it!
  my $pos = 0;
  loop (my $x = 0; $x < TEXTURE_SIZE; $x++) {
    loop (my $y = 0; $y < TEXTURE_SIZE; $y++) {
      my $dx = $x - TEXTURE_SIZE / 2;
      my $dy = $y - TEXTURE_SIZE / 2;
      my $v  = sqrt($dx * $dx *$dy *$dy) * 255 / TEXTURE_SIZE / 2;
      
      $v := 255 if $v > 255;
      $p[$pos++] = $v;
      $p[$pos++] = $v;
      $p[$pos++] = $v;
      $p[$pos++] = $v;
    }
  }
  
  my $tex = COGL::Texture2d.new_from_data(
    $context, 
    TEXTURE_SIZE, TEXTURE_SIZE
    COGL_PIXEL_FORMAT_RGBA_8888_PRE,
    TEXTURE_SIZE * 4,
    cast(Pointer, $p)
  );
  
  $tex;
}
     
sub paint (%data) {
  my $diff-time;
  
  loop (my $i; $i < N_FIREWORKS; $i++) {
    my $firework := %data<fireworks>[$i];
    
    if 
      abs($firework.x - $firework.start-x) > 2 ||
      $firework.y < 1
    {
      $firework.size = (0.001e0 ..^ 0.1e0).rand;
      $firework.start-x = 1 + $firework.size;
      $firework.start-y = -1;
      $firework.initial-x-velocity = (-2e0 ^.. -0.1e0).rand;
      $firework.initial-y-velocity = (0.1e0 ..^ 4e0).rand;
      $firework.timer.reset();
      
      my $range = ^(^3.pick);
      my $c = <red green blue>;
      for $range {
        %firework.color."$c[$_]"() = Bool.pick ?? 255 !! 0;
      }
      $firework.color.alpha = 255;
        
      if Bool.pick {
        $firework.start-x *= -1;
        $firework.initial-x-velocity *= -1;
      }
    }
    
    $diff-time = %data<last-spark-time>.elapsed;
    
    $firework.x = $firework.start-x +
                  $firework.initial-x-velocity * $diff-time;
                  
    $firework.y = $firework.start-y +
                  $firework.initial-y-velocity * $diff-time +
                  0.5 * GRAVITY * $diff-time²;
  }
      
  $diff-time = %data<last-spark-time>.elapsed;
  unless $diff_time ~~ 0..TIME_PER_SPARK {
    loop (my $i = 0; $i < N_FIREWORKS, $i++) {
      my $spark := %data<sparks>[%data<next-spark-num>];
      my $firework := %data<fireworks>[$i];
      
      $spark.x = 
        ($firework.x + (-$firework.size/2e0 ..^ $firework.size/2e0).rand;
      $spark<y> = 
        ($firework.y + (-$firework.size/2e0 ..^ $firework.size/2e0).rand;
        
      $spark.base-color := $firework.color;
      
      %data<next-spark-num> = %data<next-spark-num> +& (N_SPARKS - 1);
    }
  
    # Update the colour of each spark
    loop (my $i = 0; $i < N_SPARKS; $i++) {
      my $spark := %data<sparks>[
        %data<next-spark-num> + $i +& (N_SPARKS - 1)
      ];
      
      my $cv = $i / (N_SPARKS - 1);
      $spark.base-color.red   *= $cv;
      $spark.base-color.green *= $cv;
      $spark.base-color.blue  *= $cv;
      
      $spark.base-color.alpha = 255 * $cv;
    }
    
    %data<last-spark-time>.reset();
  }
  
  %data<attribute-buffer>.set_data(
    0,
    %data<sparks>,
    nativesizeof(%data<sparks>),
  );

  %data<fb>.clear4f(COGL_BUFFER_BIT_COLOR, 0, 0, 0, 1);
  %data<primitive>.draw(%data<fb>, %data<pipeline>);
  %data<fb>.swap_buffers;
}
          
sub create-primative (%data) {
  %data<attribute-buffer> = COGL::AttributeBuffer.new_with_size(
    %data<context>, nativesizeof(%data<sparks>)
  );
  %data<attribute-buffer>.set_update_hint(COGL_BUFFER_UPDATE_HINT_DYNAMIC);
  
  ( my $attributes = CArray[CoglAttribute].new ).allocate(2);
  $attributes[0] = COGL::Attribute.new(
    %data<attribute-buffer>, 
    'cogl_position_in', 
    nativesizeof(Spark),
    0,                                # Position of 'x' in Spark
    2,                                # Number of components in position: (x, y)
    COGL_ATTRIBUTE_TYPE_FLOAT         # Type of each component
  );
  
  $attributes[1] = COGL::Attribute.new(
    %data<attribute-buffer>, 
    'cogl_color_in', 
    nativesizeof(Spark),      
    8,                                # Position of 'color' in Spark
    4,                                # Number of components in color: (r, g, b, a)
    COGL_ATTIBUTE_TYPE_UNSIGNED_BYTE  # Type of each component
  );
  
  %data<primative> = COGL::Primative.new_with_attributes(
    COGL_VERTICIES_MODE_POINTS,
    N_SPARKS,
    $attributes,
    2
  );
  
  $attributes[$_].unref for (0, 1);
}

sub MAIN {
  my %data;
  
  %data<context> = COGL::Context.new;
  create-primatives(%data)
  
  %data<pipeline> = COGL::Pipeline.new(%data<context>);
  %data<last-spark-time> = GTK::Compat::Timer.new;
  %data<next-spark-num> = 0;
  %data<pipeline>.set_point_size(TEXTURE_SIZE);
  
  my $tex = generate-round-texture(%data<context>);
  %data<pipeline>.set_layer_texture(0, $tex);
  $tex.unref;
  
  %data<pipeline>.set_layer_point_sprite_coords_enabled(0, True);
  
  for ^N_FIREWORKS {
    %data<fireworks>[$_].x     = -FLT_MAX;
    %data<fireworks>[$_].y     = FLT_MAX;
    %data<fireworks>[$_].size  = 0;
    %data<fireworks>[$_].timer = GTK::Compat::Timer.new;
  }
  for ^N_SPARKS {
    %data<sparks>[$_].x = %data<sparks>[$_].y = 2;
  }
    
  %data<fb> = COGL::Onscreen.new(%data<context>, 800, 600);
  %data<fb>.show;
  %data<fb>.add_frame_callback(-> *@a { 
    paint(%data) if CoglFrameEvent( @a[1] ) == COGL_FRAME_EVENT_SYNC
  });
   
  my $source = COGL::Source.new(%data<context>);
  $source.attach;
 
  my $loop = GTK::Compat::Main.new(GMainContext, True);
  paint(%data);
  
  $loop.run;
  $loop.unref;
  
  %data{$_}.unref for <pipeline attribute_buffer primative fb context>;
  %data<last-spark-time>.destroy;
  .destroy for %data<fireworks>;
}
  
  
  
  
    
    
  
