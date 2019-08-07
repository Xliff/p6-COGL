use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Primative;

class COGL::Primative {
  has COGL::Primative $!cp;
  
  method cogl_is_primitive {
    cogl_is_primitive($!cp);
  }

  method cogl_primitive_copy {
    cogl_primitive_copy($!cp);
  }

  method cogl_primitive_draw (
    CoglFramebuffer $framebuffer, 
    CoglPipeline $pipeline
  ) {
    cogl_primitive_draw($!cp, $framebuffer, $pipeline);
  }

  method cogl_primitive_foreach_attribute (
    CoglPrimitiveAttributeCallback $callback, 
    gpointer $user_data
  ) {
    cogl_primitive_foreach_attribute($!cp, $callback, $user_data);
  }

  method cogl_primitive_get_first_vertex {
    cogl_primitive_get_first_vertex($!cp);
  }

  method cogl_primitive_get_gtype {
    cogl_primitive_get_gtype($!cp);
  }

  method cogl_primitive_get_indices {
    cogl_primitive_get_indices($!cp);
  }

  method cogl_primitive_get_mode {
    cogl_primitive_get_mode($!cp);
  }

  method cogl_primitive_get_n_vertices {
    cogl_primitive_get_n_vertices($!cp);
  }

  method cogl_primitive_new_p2 (
    CoglVerticesMode $mode, 
    gint $n_vertices, 
    CoglVertexP2 $data
  ) {
    cogl_primitive_new_p2($!cp, $mode, $n_vertices, $data);
  }

  method cogl_primitive_new_p2c4 (
    CoglVerticesMode $mode, 
    gint $n_vertices, 
    CoglVertexP2C4 $data
  ) {
    cogl_primitive_new_p2c4($!cp, $mode, $n_vertices, $data);
  }

  method cogl_primitive_new_p2t2 (
    CoglVerticesMode $mode, 
    gint $n_vertices, 
    CoglVertexP2T2 $data
  ) {
    cogl_primitive_new_p2t2($!cp, $mode, $n_vertices, $data);
  }

  method cogl_primitive_new_p2t2c4 (
    CoglVerticesMode $mode, 
    gint $n_vertices, 
    CoglVertexP2T2C4 $data
  ) {
    cogl_primitive_new_p2t2c4($!cp, $mode, $n_vertices, $data);
  }

  method cogl_primitive_new_p3 (
    CoglVerticesMode $mode, 
    gint $n_vertices, 
    CoglVertexP3 $data
  ) {
    cogl_primitive_new_p3($!cp, $mode, $n_vertices, $data);
  }

  method cogl_primitive_new_p3c4 (
    CoglVerticesMode $mode, 
    gint $n_vertices, 
    CoglVertexP3C4 $data
  ) {
    cogl_primitive_new_p3c4($!cp, $mode, $n_vertices, $data);
  }

  method cogl_primitive_new_p3t2 (
    CoglVerticesMode $mode, 
    gint $n_vertices, 
    CoglVertexP3T2 $data
  ) {
    cogl_primitive_new_p3t2($!cp, $mode, $n_vertices, $data);
  }

  method cogl_primitive_new_p3t2c4 (
    CoglVerticesMode $mode, 
    gint $n_vertices, 
    CoglVertexP3T2C4 $data
  ) {
    cogl_primitive_new_p3t2c4($!cp, $mode, $n_vertices, $data);
  }

  method cogl_primitive_new_with_attributes (
    gint $n_vertices, 
    CoglAttribute $attributes, 
    gint $n_attributes
  ) {
    cogl_primitive_new_with_attributes(
      $!cp, $n_vertices, $attributes, $n_attributes
    );
  }

  method cogl_primitive_set_attributes (
    CoglAttribute $attributes, 
    gint $n_attributes
  ) {
    cogl_primitive_set_attributes($!cp, $attributes, $n_attributes);
  }

  method cogl_primitive_set_first_vertex (gint $first_vertex) {
    cogl_primitive_set_first_vertex($!cp, $first_vertex);
  }

  method cogl_primitive_set_indices (CoglIndices $indices, gint $n_indices) {
    cogl_primitive_set_indices($!cp, $indices, $n_indices);
  }

  method cogl_primitive_set_mode (CoglVerticesMode $mode) {
    cogl_primitive_set_mode($!cp, $mode);
  }

  method cogl_primitive_set_n_vertices (gint $n_vertices) {
    cogl_primitive_set_n_vertices($!cp, $n_vertices);
  }

}
