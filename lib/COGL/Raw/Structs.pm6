use v6.c;

use NativeCall;

use GLib::Raw::Definitions;
use COGL::Raw::Definitions;

use GLib::Roles::Pointers;

unit package COGL::Raw::Structs;

class CoglColor is repr<CStruct>             does GLib::Roles::Pointers is export {
  has gfloat $.red;
  has gfloat $.green;
  has gfloat $.blue;
  has gfloat $.alpha;

  method new ($red, $green, $blue, $alpha) {
    self.bless(:$red, :$green, :$blue, :$alpha);
  }
}

class CoglEuler is repr<CStruct>             does GLib::Roles::Pointers is export {
  has gfloat $.heading is rw;
  has gfloat $.pitch   is rw;
  has gfloat $.roll    is rw;

  has gfloat $!padding0;
  has gfloat $!padding1;
  has gfloat $!padding2;
  has gfloat $!padding3;
  has gfloat $!padding4;
}

class CoglPollFD is repr<CStruct>            does GLib::Roles::Pointers is export {
  has gint  $.fd      is rw;
  has int16 $.events  is rw;
  has int16 $.revents is rw;
}

class CoglVertexP2 is repr<CStruct>          does GLib::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;

  method new(Num() $x, Num() $y) {
    self.bless(:$x, :$y)
  }
}

class CoglVertexP3 is repr<CStruct>          does GLib::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;

  method new(Num() $x, Num() $y, Num() $z) {
    self.bless(:$x, :$y, :$z)
  }
}

class CoglVertexP2C4 is repr<CStruct>        does GLib::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has uint8  $.r is rw;
  has uint8  $.g is rw;
  has uint8  $.b is rw;
  has uint8  $.a is rw;

  method new(Num() $x, Num() $y, Int() $r, Int()$g, Int() $b, Int() $a) {
    self.bless(:$x, :$y, :$r, :$g, :$b, :$a)
  }
}

class CoglVertexP3C4 is repr<CStruct>        does GLib::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
  has uint8  $.r is rw;
  has uint8  $.g is rw;
  has uint8  $.b is rw;
  has uint8  $.a is rw;

  method new(
    Num() $x, Num() $y, Num() $z,
    Int() $r, Int() $g, Int() $b, Int() $a
  ) {
    self.bless(:$x, :$y, :$z, :$r, :$g, :$b, :$a)
  }
}

class CoglVertexP2T2 is repr<CStruct>        does GLib::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.s is rw;
  has gfloat $.t is rw;

  method new(Num() $x, Num() $y, Num() $s, Num() $t) {
    self.bless(:$x, :$y, :$s, :$t)
  }
}

class CoglVertexP3T2 is repr<CStruct>        does GLib::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
  has gfloat $.s is rw;
  has gfloat $.t is rw;

  method new(Num() $x, Num() $y, Num() $z, Num() $s, Num() $t) {
    self.bless(:$x, :$y, :$z, :$s, :$t)
  }

}

class CoglVertexP2T2C4 is repr<CStruct>      does GLib::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.s is rw;
  has gfloat $.t is rw;
  has uint8  $.r is rw;
  has uint8  $.g is rw;
  has uint8  $.b is rw;
  has uint8  $.a is rw;

  method new(
    Num() $x, Num() $y,
    Num() $s, Num() $t,
    Int() $r, Int() $g, Int() $b, Int() $a
  ) {
    self.bless(:$x, :$y, :$s, :$t, :$r, :$g, :$b, :$a)
  }
}

class CoglVertexP3T2C4 is repr<CStruct>      does GLib::Roles::Pointers is export {
  has gfloat $.x is rw;
  has gfloat $.y is rw;
  has gfloat $.z is rw;
  has gfloat $.s is rw;
  has gfloat $.t is rw;
  has uint8  $.r is rw;
  has uint8  $.g is rw;
  has uint8  $.b is rw;
  has uint8  $.a is rw;

  method new(
    Num() $x, Num() $y, Num() $z,
    Num() $s, Num() $t,
    Int() $r, Int() $g, Int() $b, Int() $a
  ) {
    self.bless(:$x, :$y, :$z, :$s, :$t, :$r, :$g, :$b, :$a)
  }
}

class CoglUserDataKey is repr<CStruct>       does GLib::Roles::Pointers is export {
  has gint $.unused;
}

class CoglOnscreenDirtyInfo is repr<CStruct> does GLib::Roles::Pointers is export {
  has gint $.x      is rw;
  has gint $.y      is rw;
  has gint $.width  is rw;
  has gint $.height is rw;
}

class CoglDepthState is repr<CStruct>        does GLib::Roles::Pointers is export {
  # private >
  has uint32   $.magic;

  has CoglBool $.test_enabled;
  has guint    $.test_function;
  has CoglBool $.write_enabled;
  has gfloat   $.range_near;
  has gfloat   $.range_far;

  has uint32   $.padding0;
  has uint32   $.padding1;
  has uint32   $.padding2;
  has uint32   $.padding3;
  has uint32   $.padding4;
  has uint32   $.padding5;
  has uint32   $.padding6;
  has uint32   $.padding7;
  has uint32   $.padding8;
  has uint32   $.padding9;
}

class CoglMatrix is repr<CStruct>            does GLib::Roles::Pointers is export {
  # column 0
  has gfloat $.xx is rw;
  has gfloat $.yx is rw;
  has gfloat $.zx is rw;
  has gfloat $.wx is rw;

  # column 1
  has gfloat $.xy is rw;
  has gfloat $.yy is rw;
  has gfloat $.zy is rw;
  has gfloat $.wy is rw;

  # column 2
  has gfloat $.xz is rw;
  has gfloat $.yz is rw;
  has gfloat $.zz is rw;
  has gfloat $.wz is rw;

  # column 3
  has gfloat $.xw is rw;
  has gfloat $.yw is rw;
  has gfloat $.zw is rw;
  has gfloat $.ww is rw;

  HAS gfloat @!inv[16] is CArray;
  has gulong $!type;
  has gulong $!flags;
  has gulong $!padding3;
}

class CoglQuaternion is repr<CStruct>        does GLib::Roles::Pointers is export {
  has gfloat $.w;
  has gfloat $.x;
  has gfloat $.y;
  has gfloat $.z;

  has gfloat $!padding0;
  has gfloat $!padding1;
  has gfloat $!padding2;
  has gfloat $!padding3;
}
