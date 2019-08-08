use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Objects;

class COGL::Object {
  has CoglObject $!co;
  
  method setObject (CoglObject $o) {
    $!co = $o;
  } 
   
  method debug_object_foreach_type (gpointer $user_data = gpointer) {
    cogl_debug_object_foreach_type($!co, $user_data);
  }

  method debug_object_print_instances {
    cogl_debug_object_print_instances($!co);
  }

  method object_get_gtype {
    state ($n, $t)
    unstable_get_type( self.^name, &cogl_object_get_gtype, $n, $t );
  }

  method get_user_data (CoglUserDataKey $key) {
    cogl_object_get_user_data($!co, $key);
  }

  method ref {
    cogl_object_ref($!co);
  }

  method set_user_data (
    CoglUserDataKey $key, 
    gpointer $user_data, 
    CoglUserDataDestroyCallback $destroy
  ) {
    cogl_object_set_user_data($!co, $key, $user_data, $destroy);
  }

  method unref {
    cogl_object_unref($!co);
  }
  
}
