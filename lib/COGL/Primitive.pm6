use v6.c;

use NativeCall;
use Method::Also;

use COGL::Raw::Types;
use COGL::Raw::Primitive;

use GLib::Roles::TypedBuffer;

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
        self.setObject($to-parent);
      }

      when COGL::Primitive {
      }

      default {
      }
    }
  }

  proto method new_p2 (|)
    is also<new-p2>
  { * }

  multi method new_p2 (
    CoglContext() $context,
    Int() $mode,
    GLib::Roles::TypedBuffer[CoglVertexP2] $data # CoglVertexP2 *data
  ) {
    samewith($context, $mode, $data.elems, $data.p);
  }
  multi method new_p2 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP2 *data
  ) {
    my guint $m = $mode;
    my gint $nv = $n_vertices;
    my $primitive = cogl_primitive_new_p2($context, $m, $nv, $data);

    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  proto method new_p2c4 (|)
    is also<new-p2c4>
  { * }

  multi method new_p2c4 (
    CoglContext() $context,
    Int() $mode,
    GLib::Roles::TypedBuffer[CoglVertexP2C4] $data
  ) {
    samewith($context, $mode, $data.elems, $data.p);
  }
  multi method new_p2c4 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP2C4 *data
  ) {
    my guint $m = $mode;
    my gint $nv = $n_vertices;
    my $primitive = cogl_primitive_new_p2c4($context, $m, $nv, $data);
    
    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  proto method new_p2t2 (|)
    is also<new-p2t2>
  { * }

  multi method new_p2t2 (
    CoglContext() $context,
    Int() $mode,
    GLib::Roles::TypedBuffer[CoglVertexP2T2] $data
  ) {
    samewith($context, $mode, $data.elems, $data.p);
  }
  multi method new_p2t2 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP2T2 *data
  ) {
    my guint $m = $mode;
    my gint $nv = $n_vertices;
    my $primitive = cogl_primitive_new_p2t2($context, $m, $nv, $data);

    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  proto method new_p2t2c4 (|)
    is also<new-p2t2c4>
  { * }

  multi method new_p2t2c4 (
    CoglContext() $context,
    Int() $mode,
    GLib::Roles::TypedBuffer[CoglVertexP2T2C4] $data
  ) {
    samewith($context, $mode, $data.elems, $data.p);
  }
  multi method new_p2t2c4 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP2T2C4 *data
  ) {
    my guint $m = $mode;
    my gint $nv = $n_vertices;
    my $primitive = cogl_primitive_new_p2t2c4($context, $m, $nv, $data);

    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  proto method new_p3 (|)
    is also<new-p3>
  { * }

  multi method new_p3 (
    CoglContext() $context,
    Int() $mode,
    GLib::Roles::TypedBuffer[CoglVertexP3] $data
  ) {
    samewith($context, $mode, $data.elems, $data.p);
  }
  multi method new_p3 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP3 *data
  ) {
    my guint $m = $mode;
    my gint $nv = $n_vertices;
    my $primitive = cogl_primitive_new_p3($context, $m, $nv, $data);

    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  proto method new_p3c4 (|)
    is also<new-p3c4>
  { * }

  multi method new_p3c4 (
    CoglContext() $context,
    Int() $mode,
    GLib::Roles::TypedBuffer[CoglVertexP3C4] $data
  ) {
    samewith($context, $mode, $data.elems, $data.p);
  }
  multi method new_p3c4 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP3C4 *data
  ) {
    my guint $m = $mode;
    my gint $nv = $n_vertices;
    my $primitive = cogl_primitive_new_p3c4($context, $m, $nv, $data);

    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  proto method new_p3t2 (|)
    is also<new-p3t2>
  { * }

  multi method new_p3t2 (
    CoglContext() $context,
    Int() $mode,
    GLib::Roles::TypedBuffer[CoglVertexP3T2] $data
  ) {
    samewith($context, $mode, $data.elems, $data.p);
  }
  multi method new_p3t2 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP3T2 *data
  ) {
    my guint $m = $mode;
    my gint $nv = $n_vertices;
    my $primitive = cogl_primitive_new_p3t2($context, $m, $nv, $data);

    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  proto method new_p3t2c4 (|)
    is also<new-p3t2c4>
  { * }

  multi method new_p3t2c4 (
    CoglContext() $context,
    Int() $mode,
    GLib::Roles::TypedBuffer[CoglVertexP3T2C4] $data
  ) {
    samewith($context, $mode, $data.elems, $data.p);
  }
  multi method new_p3t2c4 (
    CoglContext() $context,
    Int() $mode,
    Int() $n_vertices,
    gpointer $data # CoglVertexP3T2C4 *data
  ) {
    my guint $m = $mode;
    my gint $nv = $n_vertices;
    my $primitive = cogl_primitive_new_p3t2c4($context, $m, $nv, $data);

    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  method new_with_attributes (
    Int() $mode,
    Int() $n_vertices,
    CArray[CoglAttribute] $attributes,
    Int() $n_attributes
  )
    is also<new-with-attributes>
  {
    my guint $m = $mode;
    my gint ($nv, $na) = ($n_vertices, $n_attributes);
    my $primitive = cogl_primitive_new_with_attributes(
      $m,
      $nv,
      $attributes,
      $na
    );

    $primitive ?? self.bless(:$primitive) !! Nil;
  }

  method is_primitive (COGL::Primitive:U: gpointer $candidate)
    is also<is-primitive>
  {
    so cogl_is_primitive($candidate);
  }

  method copy (:$raw = False) {
    my $c = cogl_primitive_copy($!cp);

    $c ??
      ( $raw ?? $c !! COGL::Primitive.new($c) )
      !!
      Nil;
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

  method get_indices (:$raw = False) is also<get-indices> {
    my $i = cogl_primitive_get_indices($!cp);

    $i ??
      ( $raw ?? $i !! COGL::Indicies.new($i) )
      !!
      Nil;
  }

  method get_mode is also<get-mode> {
    CoglVerticesModeEnum( cogl_primitive_get_mode($!cp) );
  }

  method get_n_vertices
    is also<
      get-n-vertices
      elems
    >
  {
    cogl_primitive_get_n_vertices($!cp);
  }

  method set_attributes (
    CArray[CoglAttribute] $attributes,
    Int() $n_attributes
  )
    is also<set-attributes>
  {
    my gint $na = $n_attributes;

    cogl_primitive_set_attributes($!cp, $attributes, $na);
  }

  method set_first_vertex (Int() $first_vertex) is also<set-first-vertex> {
    my gint $fv = $first_vertex;

    cogl_primitive_set_first_vertex($!cp, $first_vertex);
  }

  method set_indices (
    gpointer $indices, # CoglIndices *indices,
    Int() $n_indices
  )
    is also<set-indices>
  {
    my gint $ni = $n_indices;

    cogl_primitive_set_indices($!cp, $indices, $ni);
  }

  method set_mode (Int() $mode) is also<set-mode> {
    my guint $m = $mode;

    cogl_primitive_set_mode($!cp, $m);
  }

  method set_n_vertices (Int() $n_vertices) is also<set-n-vertices> {
    my gint $nv = $n_vertices;

    cogl_primitive_set_n_vertices($!cp, $nv);
  }

}
