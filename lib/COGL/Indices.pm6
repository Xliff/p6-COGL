use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Indices;

use GTK::Raw::Utils;

class COGL::Indices {
  has CoglIndices $!ci;
  
  submethod BUILD (:$indices) {
    $!ci = $indices;
  }
  
  method COGL::Raw::Types::CoglIndices
  { $!ci }
  
  method new (
    CoglContext() $context, 
    Int() $type, 
    gpointer $indices_data, 
    Int() $n_indices
  ) {
    my guint $t = resolve-uint($type);
    my gint $n  = resolve-int($n_indices);
    
    self.bless( indices => cogl_indices_new($context, $t, $indices_data, $n) );
  }

  method new_for_buffer (CoglIndexBuffer() $buffer, Int() $offset) {
    my gsize $o = resolve-long($offset);
    
    self.bless( indices => cogl_indices_new_for_buffer($!ci, $buffer, $o) );
  }
  
  method offset is rw {
    Proxy.new(
      FETCH => sub ($) {
        cogl_indices_get_offset($!ci);
      },
      STORE => sub ($, Int() $offset is copy) {
        my gsize $o = resolve-long($offset);
        
        cogl_indices_set_offset($!ci, $o);
      }
    );
  }
  
  method get_rectangle_indices (
    COGL::Indices:U: 
    CoglContext() $context, 
    Int() $n_rectangles
  ) {
    my gint $nr = resolve-int($n_rectangles);
    
    cogl_get_rectangle_indices($context, $nr);
  }

  method is_indices (COGL::Indices:U: gpointer $candidate) {
    so cogl_is_indices($candidate);
  }

  method get_buffer (:$raw = False) {
    my $i = cogl_indices_get_buffer($!ci);
    $i ??
      ( $raw ?? $i !! COGL::IndexBuffer.new($i) )
      !!
      Nil;
  }

  method get_gtype {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_indices_get_gtype, $n, $t );
  }

  # Y'all actually use GLib and thought this WOULDN'T be confusing? Now I have
  # to go back and check my wrappers of y'all shit. :(      %)
  method get_type {
    CoglIndicesType( cogl_indices_get_type($!ci) );
  }

}