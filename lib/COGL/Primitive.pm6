use v6.c;

use NativeCall;
use Method::Also;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Primitive;

use COGL::Object;

our subset PrimitiveAncestry is export of Mu
  where CoglPrimitive | CoglObject;

class COGL::Primitive is COGL::Object {
  has CoglPrimitive $!cp;

  submethod BUILD (:$primitive) {
    given $primitive {
      when PrimitiveAncestry {
        my $to-parent;
        $!cp = do {
          when CoglPrimitive {
            $to-parent = cast(CoglObject, $_);
            $_;
          }

          default {
            $to-parent = $_;
            cast(CoglPrimitive, $_);
          }
        }
        self.setParent($to-parent);
      }

      when COGL::Primitive {
      }

      default {
      }
    }
  }

  method new_p2 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP2 *data
  )
    is also<new-p2>
  {
    my guint $m = resolve-uint($mode);
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_new_p2($context, $m, $nv, $data);
  }

  method new_p2c4 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP2C4 *data
  )
    is also<new-p2c4>
  {
    my guint $m = resolve-uint($mode);
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_new_p2c4($context, $m, $nv, $data);
  }

  method new_p2t2 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP2T2 *data
  )
    is also<new-p2t2>
  {
    my guint $m = resolve-uint($mode);
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_new_p2t2($context, $m, $nv, $data);
  }

  method new_p2t2c4 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP2T2C4 *data
  )
    is also<new-p2t2c4>
  {
    my guint $m = resolve-uint($mode);
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_new_p2t2c4($context, $m, $nv, $data);
  }

  method new_p3 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP3 *data
  )
    is also<new-p3>
  {
    my guint $m = resolve-uint($mode);
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_new_p3($context, $m, $nv, $data);
  }

  method new_p3c4 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP3C4 *data
  )
    is also<new-p3c4>
  {
    my guint $m = resolve-uint($mode);
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_new_p3c4($context, $m, $nv, $data);
  }

  method new_p3t2 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP3T2 *data
  )
    is also<new-p3t2>
  {
    my guint $m = resolve-uint($mode);
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_new_p3t2($context, $m, $nv, $data);
  }

  method new_p3t2c4 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP3T2C4 *data
  )
    is also<new-p3t2c4>
  {
    my guint $m = resolve-uint($mode);
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_new_p3t2c4($context, $m, $nv, $data);
  }

  method new_with_attributes (
    CoglContext() $context,
    Int() $n_vertices,
    CArray[CoglAttribute] $attributes,
    Int() $n_attributes
  )
    is also<new-with-attributes>
  {
    my gint ($nv, $na) = resolve-int($n_vertices, $n_attributes);

    cogl_primitive_new_with_attributes($context, $nv, $attributes, $na);
  }

  method is_primitive (COGL::Primitive:U: gpointer $candidate)
    is also<is-primitive>
  {
    cogl_is_primitive($candidate);
  }

  method copy {
    cogl_primitive_copy($!cp);
  }

  method draw (
    CoglFrameBuffer() $framebuffer,
    CoglPipeline() $pipeline
  ) {
    cogl_primitive_draw($!cp, $framebuffer, $pipeline);
  }

  method foreach_attribute (
    &callback,
    gpointer $user_data = gpointer
  )
    is also<foreach-attribute>
  {
    cogl_primitive_foreach_attribute($!cp, &callback, $user_data);
  }

  method get_first_vertex is also<get-first-vertex> {
    cogl_primitive_get_first_vertex($!cp);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_primitive_get_gtype, $n, $t );
  }

  method get_indices is also<get-indices> {
    cogl_primitive_get_indices($!cp);
  }

  method get_mode is also<get-mode> {
    cogl_primitive_get_mode($!cp);
  }

  method get_n_vertices is also<get-n-vertices> {
    CoglVerticesMode( cogl_primitive_get_n_vertices($!cp) );
  }

  method set_attributes (
    CArray[CoglAttribute] $attributes,
    Int() $n_attributes
  )
    is also<set-attributes>
  {
    my gint $na = resolve-int($n_attributes);

    cogl_primitive_set_attributes($!cp, $attributes, $na);
  }

  method set_first_vertex (Int() $first_vertex) is also<set-first-vertex> {
    my gint $fv = resolve-int($first_vertex);

    cogl_primitive_set_first_vertex($!cp, $first_vertex);
  }

  method set_indices (
    CArray[CoglIndices] $indices, # CoglIndices *indices,
    Int() $n_indices
  )
    is also<set-indices>
  {
    my gint $ni = resolve-int($n_indices);

    cogl_primitive_set_indices($!cp, $indices, $ni);
  }

  method set_mode (Int() $mode) is also<set-mode> {
    my guint $m = resolve-uint($mode);

    cogl_primitive_set_mode($!cp, $m);
  }

  method set_n_vertices (Int() $n_vertices) is also<set-n-vertices> {
    my gint $nv = resolve-int($n_vertices);

    cogl_primitive_set_n_vertices($!cp, $nv);
  }

}
