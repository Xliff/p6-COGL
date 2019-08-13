use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use GTK::Roles::Pointers;
use COGL::Raw::Types;

use GTK::Compat::Timer;

unit package Fireworks;

constant N_FIREWORKS    is export = 32              ;
constant N_SPARKS       is export = N_FIREWORKS * 32;
constant TEXTURE_SIZE   is export = 32              ;
constant TIME_PER_SPARK is export = 0.1             ;
constant GRAVITY        is export = -1.5            ;
constant FLT_MAX        is export = 3.402823e38     ;   # C define value

class Color is repr<CStruct> is export does GTK::Roles::Pointers {
  has uint8 $!red  ;
  has uint8 $!green;
  has uint8 $!blue ;
  has uint8 $!alpha;
  
  method red is rw {
    Proxy.new: 
      FETCH => -> $s { $!red },
      STORE => -> $, Int() $red { 
        my uint8 $c = resolve-uint8($red);
        
        $!red = $c;
      };
  }
  
  method green is rw {
    Proxy.new: 
      FETCH => -> $s { $!green },
      STORE => -> $, Int() $green { 
        my uint8 $c = resolve-uint8($green);
        
        $!green = $c;
      };
  }
  
  method blue is rw {
    Proxy.new: 
      FETCH => -> $s { $!blue },
      STORE => -> $, Int() $blue { 
        my uint8 $c = resolve-uint8($blue);
        
        $!blue = $c;
      };
  }
  
  method alpha is rw {
    Proxy.new: 
      FETCH => -> $s { $!alpha },
      STORE => -> $, Int() $alpha { 
        my uint8 $c = resolve-uint8($alpha);
        
        $!alpha = $c;
      };
  }
  
}

class Firework is repr<CStruct> is export does GTK::Roles::Pointers {
  my $timer-attr = Firework.^attributes[* - 1];

  has gfloat $!size              ;
  has gfloat $!x                 ;
  has gfloat $!y                 ;
  has gfloat $!start-x           ;
  has gfloat $!start-y           ;
  has gfloat $!initial-x-velocity;
  has gfloat $!initial-y-velocity;

  HAS Color  $.color;

  has GTimer $!timer;
  
  # Make things easier on the user.
  method x is rw {
    Proxy.new: 
      FETCH => -> $ { $!x },
      STORE => -> $, Num() $x { 
        my gfloat $xx = $x;
        
        $!x = $xx;
      };
  }
  
  method y is rw {
    Proxy.new: 
      FETCH => -> $ { $!y },
      STORE => -> $, Num() $y { 
        my gfloat $yy = $y;
        
        $!y = $yy;
      };
  }
  
  method size is rw {
    Proxy.new: 
      FETCH => -> $ { $!size },
      STORE => -> $, Num() $size { 
        my gfloat $s = $size;
        
        $!size = $s;
      };
  }
  
  method start-x is rw {
    Proxy.new: 
      FETCH => -> $ { $!start-x },
      STORE => -> $, Num() $start-x { 
        my gfloat $sx = $start-x;
        
        $!start-x = $sx;
      };
  }
    
  method start-y is rw {
    Proxy.new: 
      FETCH => -> $ { $!start-y },
      STORE => -> $, Num() $start-y { 
        my gfloat $sy = $start-y;
        
        $!start-y = $sy;
      };
  }
  
  method initial-x-velocity is rw {
    Proxy.new: 
      FETCH => -> $ { $!initial-x-velocity },
      STORE => -> $, Num() $initial-x-velocity { 
        my gfloat $ix = $initial-x-velocity;
        
        $!initial-x-velocity = $ix
      };
  }
  
  method initial-y-velocity is rw {
    Proxy.new: 
      FETCH => -> $ { $!initial-y-velocity },
      STORE => -> $, Num() $initial-y-velocity { 
        my gfloat $iy = $initial-y-velocity;
        
        $!initial-y-velocity = $iy
      };
  }

  method timer(:$raw) is rw {
    Proxy.new:
      FETCH => -> $ { $raw ?? $!timer !! GTK::Compat::Timer.new($!timer) },
      STORE => -> $, GTimer() \val { $timer-attr.set_value(self, val) };
  }
  
}

class Spark is repr<CStruct> is export {
  my $color-attr      = Spark.^attributes[* - 2];
  my $base-color-attr = Spark.^attributes[* - 1];
  
  has gfloat $!x;
  has gfloat $!y;

  HAS Color  $!color;
  HAS Color  $!base-color;
  
  submethod BUILD {
    self.color      = Color.new;
    self.base-color = Color.new;
  }
  
  method x is rw {
    Proxy.new: 
      FETCH => -> $ { $!x },
      STORE => -> $, Num() $x { 
        my gfloat $xx = $x;
        
        $!x = $xx;
      };
  }
  
  method y is rw {
    Proxy.new: 
      FETCH => -> $ { $!y },
      STORE => -> $, Num() $y { 
        my gfloat $yy = $y;
        
        $!y = $yy;
      };
  }
  
  method color is rw {
    Proxy.new:
      FETCH => -> $ { $!color },
      STORE => -> $, Color \val { $color-attr.set_value(self, val) };
  }
  
  method base-color is rw {
    Proxy.new:
      FETCH => -> $ { $!base-color },
      STORE => -> $, Color \val { $base-color-attr.set_value(self, val) };
  }
  
}
