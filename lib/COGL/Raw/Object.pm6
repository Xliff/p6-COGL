use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Object;

sub cogl_debug_object_foreach_type (
  CoglDebugObjectForeachTypeCallback $func, 
  Pointer $user_data
)
  is native(cogl)
  is export
{ * }

sub cogl_debug_object_print_instances ()
  is native(cogl)
  is export
{ * }

sub cogl_object_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_object_get_user_data (CoglObject $object, CoglUserDataKey $key)
  is native(cogl)
  is export
{ * }

sub cogl_object_ref (CoglObject $object)
  is native(cogl)
  is export
{ * }

sub cogl_object_set_user_data (
  CoglObject $object, 
  CoglUserDataKey $key, 
  Pointer $user_data, 
  CoglUserDataDestroyCallback $destroy
)
  is native(cogl)
  is export
{ * }

sub cogl_object_unref (CoglObject $object)
  is native(cogl)
  is export
{ * }
