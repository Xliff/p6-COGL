use v6.c;

use GLib::Roles::Pointers;
use COGL::Raw::Types;

use GLib::Timer;

unit package Fireworks;

constant N_FIREWORKS    is export = 32              ;
constant N_SPARKS       is export = N_FIREWORKS * 32;
constant TEXTURE_SIZE   is export = 32              ;
constant TIME_PER_SPARK is export = 0.1             ;
constant GRAVITY        is export = -1.5            ;
constant FLT_MAX        is export = 3.402823e38     ;   # C define value

class Color is repr<CStruct> is export does GLib::Roles::Pointers {
  has uint8 $!red  ;
  has uint8 $!green;
  has uint8 $!blue ;
  has uint8 $!alpha;

  method red is rw {
    Proxy.new:
      FETCH => -> $s { $!red },
      STORE => -> $, Int() $red {
        my uint8 $c = $red;

        $!red = $c;
      };
  }

  method green is rw {
    Proxy.new:
      FETCH => -> $s { $!green },
      STORE => -> $, Int() $green {
        my uint8 $c = $green;

        $!green = $c;
      };
  }

  method blue is rw {
    Proxy.new:
      FETCH => -> $s { $!blue },
      STORE => -> $, Int() $blue {
        my uint8 $c = $blue;

        $!blue = $c;
      };
  }

  method alpha is rw {
    Proxy.new:
      FETCH => -> $s { $!alpha },
      STORE => -> $, Int() $alpha {
        my uint8 $c = $alpha;

        $!alpha = $c;
      };
  }

}

class Firework is repr<CStruct> is export does GLib::Roles::Pointers {
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

  method timer(:$raw) is rw {
    Proxy.new:
      FETCH => -> $ { $raw ?? $!timer !! GLib::Timer.new($!timer) },
      STORE => -> $, GTimer() \val { $timer-attr.set_value(self, val) };
  }

}

class Spark is repr<CStruct> is export does GLib::Roles::Pointers {
  my $color-attr      = Spark.^attributes[* - 2];
  my $base-color-attr = Spark.^attributes[* - 1];

  has gfloat $.x is rw;
  has gfloat $.y is rw;

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
