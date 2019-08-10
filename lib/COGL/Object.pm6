use v6.c;

use Method::Also;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Object;

class COGL::Object {
  has CoglObject $!co;

  method COGL::Raw::Types::CoglObject
    is also<CoglObject>
  { $!co }

  method setObject (CoglObject $o) {
    $!co = $o;
  }

  method debug_object_foreach_type (
    gpointer $func,
    gpointer $user_data = gpointer
  )
    is also<debug-object-foreach-type>
  {
    cogl_debug_object_foreach_type($func, $user_data);
  }

  method debug_object_print_instances is also<debug-object-print-instances> {
    cogl_debug_object_print_instances();
  }

  method object_get_gtype is also<object-get-gtype> {
    state ($n, $t);
    unstable_get_type( self.^name, &cogl_object_get_gtype, $n, $t );
  }

  method get_user_data (CoglUserDataKey $key) is also<get-user-data> {
    cogl_object_get_user_data($!co, $key);
  }

  method ref {
    cogl_object_ref($!co);
    self;
  }

  method set_user_data (
    CoglUserDataKey $key,
    gpointer $user_data                  = gpointer,
    CoglUserDataDestroyCallback $destroy = gpointer
  )
    is also<set-user-data>
  {
    cogl_object_set_user_data($!co, $key, $user_data, $destroy);
  }

  method unref {
    cogl_object_unref($!co);
  }

}
