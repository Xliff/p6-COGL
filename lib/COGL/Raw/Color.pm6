use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Color;

sub cogl_color_copy (CoglColor $color)
  returns CoglColor
  is native(cogl)
  is export
{ * }

sub cogl_color_equal (CoglColor $v1, CoglColor $v2)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_color_free (CoglColor $color)
  is native(cogl)
  is export
{ * }

sub cogl_color_get_alpha_byte (CoglColor $color)
  returns char
  is native(cogl)
  is export
{ * }

sub cogl_color_get_blue_byte (CoglColor $color)
  returns char
  is native(cogl)
  is export
{ * }

sub cogl_color_get_green_byte (CoglColor $color)
  returns char
  is native(cogl)
  is export
{ * }

sub cogl_color_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_color_get_red_byte (CoglColor $color)
  returns char
  is native(cogl)
  is export
{ * }

sub cogl_color_init_from_4f (
  CoglColor $color, 
  gfloat $red, 
  gfloat $green, 
  gfloat $blue, 
  gfloat $alpha
)
  is native(cogl)
  is export
{ * }

sub cogl_color_init_from_4fv (
  CoglColor $color, 
  CArray[gfloat] $color_array
)
  is native(cogl)
  is export
{ * }

sub cogl_color_init_from_4ub (
  CoglColor $color, 
  uint8_t $red, 
  uint8_t $green, 
  uint8_t $blue, 
  uint8_t $alpha
)
  is native(cogl)
  is export
{ * }

sub cogl_color_init_from_hsl (
  CoglColor $color, 
  gfloat $hue, 
  gfloat $saturation, 
  gfloat $luminance
)
  is native(cogl)
  is export
{ * }

sub cogl_color_new ()
  returns CoglColor
  is native(cogl)
  is export
{ * }

sub cogl_color_premultiply (CoglColor $color)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_from_4f (
  CoglColor $color, 
  gfloat $red, 
  gfloat $green, 
  gfloat $blue, 
  gfloat $alpha
)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_from_4ub (
  CoglColor $color, 
  uint8_t $red, 
  uint8_t $green, 
  uint8_t $blue, 
  uint8_t $alpha
)
  is native(cogl)
  is export
{ * }

sub cogl_color_to_hsl (
  CoglColor $color, 
  gfloat $hue, 
  gfloat $saturation, 
  gfloat $luminance
)
  is native(cogl)
  is export
{ * }

sub cogl_color_unpremultiply (CoglColor $color)
  is native(cogl)
  is export
{ * }

sub cogl_color_get_alpha (CoglColor $color)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_color_get_alpha_float (CoglColor $color)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_color_get_blue (CoglColor $color)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_color_get_blue_float (CoglColor $color)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_color_get_green (CoglColor $color)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_color_get_green_float (CoglColor $color)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_color_get_red (CoglColor $color)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_color_get_red_float (CoglColor $color)
  returns float
  is native(cogl)
  is export
{ * }

sub cogl_color_set_alpha (CoglColor $color, gfloat $alpha)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_alpha_float (CoglColor $color, gfloat $alpha)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_blue (CoglColor $color, gfloat $blue)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_blue_float (CoglColor $color, gfloat $blue)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_green (CoglColor $color, gfloat $green)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_green_float (CoglColor $color, gfloat $green)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_red (CoglColor $color, gfloat $red)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_red_float (CoglColor $color, gfloat $red)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_alpha_byte (CoglColor $color, uint8 $alpha)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_red_byte (CoglColor $color, uint8 $red)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_green_byte (CoglColor $color, uint8 $green)
  is native(cogl)
  is export
{ * }

sub cogl_color_set_alpha_byte (CoglColor $color, uint8 $blue)
  is native(cogl)
  is export
{ * }
