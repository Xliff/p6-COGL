use v6.c;

use NativeCall;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Context;

# sub cogl_android_set_native_window (ANativeWindow $window)
#   is native(cogl)
#   is export
# { * }

sub cogl_foreach_feature (
  CoglContext $context,
  &callback (guint, Pointer),
  Pointer $user_data
)
  is native(cogl)
  is export
{ * }

sub cogl_get_clock_time (CoglContext $context)
  returns int64
  is native(cogl)
  is export
{ * }

sub cogl_has_feature (
  CoglContext $context,
  guint $feature # CoglFeatureID $feature
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_is_context (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_context_get_display (CoglContext $context)
  returns CoglDisplay
  is native(cogl)
  is export
{ * }

sub cogl_context_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_context_get_renderer (CoglContext $context)
  returns CoglRenderer
  is native(cogl)
  is export
{ * }

sub cogl_context_new (CoglDisplay $display, CArray[Pointer[CoglError]] $error)
  returns CoglContext
  is native(cogl)
  is export
{ * }
