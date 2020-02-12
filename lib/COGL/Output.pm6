use v6.c;

use Method::Also;

use COGL::Raw::Types;
use COGL::Raw::Output;

class COGL::Output {
  has CoglOutput $!co;

  method setOutput (CoglOutput $output) {
    $!co = $output;
  }

  method COGL::Raw::Definitions::CoglOutput
    is also<CoglOutput>
  { $!co }

  proto method is_output (|)
    is also<is-output>
  { * }

  multi method is_output {
    COGL::Output.is_output($!co);
  }
  multi method is_output (COGL::Output:U: gpointer $candidate) {
    so cogl_is_output($candidate);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_output_get_gtype, $n, $t );
  }

  method get_height
    is also<
      get-height
      height
    >
  {
    cogl_output_get_height($!co);
  }

  method get_mm_height
    is also<
      get-mm-height
      mm_height
      mm-height
    >
  {
    cogl_output_get_mm_height($!co);
  }

  method get_mm_width
    is also<
      get-mm-width
      mm_width
      mm-width
    >
  {
    cogl_output_get_mm_width($!co);
  }

  method get_refresh_rate
    is also<
      get-refresh-rate
      refresh_rate
      refresh-rate
    >
  {
    cogl_output_get_refresh_rate($!co);
  }

  method get_subpixel_order
    is also<
      get-subpixel-order
      subpixel_order
      subpixel-order
    >
  {
    CoglSubpixelOrderEnum( cogl_output_get_subpixel_order($!co) );
  }

  method get_width
    is also<
      get-width
      width
    >
  {
    cogl_output_get_width($!co);
  }

  method get_x
    is also<
      get-x
      x
    >
  {
    cogl_output_get_x($!co);
  }

  method get_y
    is also<
      get-y
      y
    >
  {
    cogl_output_get_y($!co);
  }

}
