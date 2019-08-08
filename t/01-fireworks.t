use v6.c;

# There will likely be no way around this at the end-user level.
use NativeCall;

use GTK::Compat::Types;
use GTK::Compat::Timer;

use COGL::Texture2d;

constant N_FIREWORKS    = 32;
constant TEXTURE_SIZE   = 32;
constant TIME_PER_SPARK = 0.1;

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
  loop (my $i; $i < N_FIREWORKS; $i++) {
    my $firework := %data<firework>[$i];
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
    }
        
    my $diff_time = GTK::Compat::Timer.elapsed($data<last-spark-time>);
    unless $diff_time ~~ 0..TIME_PER_SPARK {
      loop (my $i = 0; $i < N_FIREWORKS, $i++) {
        my $spark := %data<sparks>[%data<next-spark-num>];
        my $firework := %data<firework>[$i];
        
        $spark.x = 
          ($firework.x + (-$firework.size/2e0 ..^ $firework.size/2e0).rand;
        $spark<y> = 
          ($firework.x + (-$firework.size/2e0 ..^ $firework.size/2e0).rand;
          
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
    
    # %data<sparks> MUST be a CStruct!
    %data<attribute_buffer>.set_data(
      0,
      %data<sparks>,
      nativesizeof(%data<sparks>),
    );

    %data<fb>.clear4f(COGL_BUFFER_BIT_COLOR, 0, 0, 0, 1);
    %data<primitive>.draw(%data<fb>, %data<pipeline>);
    %data<fb>.swap_buffers;
  }
          
        
