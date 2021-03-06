use v6.c;

use Method::Also;

use COGL::Raw::Types;
use COGL::Raw::Indices;

class COGL::Indices {
  has CoglIndices $!ci;

  submethod BUILD (:$indices) {
    $!ci = $indices;
  }

  method COGL::Raw::Definitions::CoglIndices
    is also<CoglIndices>
  { $!ci }

  method new (
    CoglContext() $context,
    Int() $type,
    gpointer $indices_data,
    Int() $n_indices
  ) {
    my guint $t = $type;
    my gint $n  = $n_indices;
    my $indices = cogl_indices_new($context, $t, $indices_data, $n);

    $indices ?? self.bless(:$indices) !! Nil;
  }

  method new_for_buffer (CoglIndexBuffer() $buffer, Int() $offset)
    is also<new-for-buffer>
  {
    my gsize $o = $offset;
    my $indices = cogl_indices_new_for_buffer($!ci, $buffer, $o);

    $indices ?? self.bless(:$indices) !! Nil;
  }

  method offset is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_indices_get_offset($!ci);
      },
      STORE => sub ($, Int() $offset is copy) {
        my gsize $o = $offset;

        cogl_indices_set_offset($!ci, $o);
      }
    );
  }

  method get_rectangle_indices (
    COGL::Indices:U:
    CoglContext() $context,
    Int() $n_rectangles,
    :$raw = False
  )
    is also<get-rectangle-indices>
  {
    my gint $nr = $n_rectangles;
    my $i = cogl_get_rectangle_indices($context, $nr);

    $i ??
      ( $raw ?? $i !! COGL::Indices.new($i) )
      !!
      Nil;
  }

  method is_indices (COGL::Indices:U: gpointer $candidate)
    is also<is-indices>
  {
    so cogl_is_indices($candidate);
  }

  method get_buffer (:$raw = False) is also<get-buffer> {
    my $i = cogl_indices_get_buffer($!ci);

    $i ??
      ( $raw ?? $i !! COGL::IndexBuffer.new($i) )
      !!
      Nil;
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_indices_get_gtype, $n, $t );
  }

  # Y'all actually use GLib and thought this WOULDN'T be confusing? Now I have
  # to go back and check my wrappers of y'all shit. :(      %)
  method get_type is also<get-type> {
    CoglIndicesTypeEnum( cogl_indices_get_type($!ci) );
  }

}
