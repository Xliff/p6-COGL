use v6.c;

use NativeCall;


use COGL::Raw::Types;

unit package COGL::OnscreenTemplate;

sub cogl_is_onscreen_template (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_template_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_template_new (CoglSwapChain $swap_chain)
  returns CoglOnscreenTemplate
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_template_set_samples_per_pixel (
  CoglOnscreenTemplate $onscreen_template, 
  gint $n
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_template_set_stereo_enabled (
  CoglOnscreenTemplate $onscreen_template, 
  CoglBool $enabled
)
  is native(cogl)
  is export
{ * }

sub cogl_onscreen_template_set_swap_throttled (
  CoglOnscreenTemplate $onscreen_template, 
  CoglBool $throttled
)
  is native(cogl)
  is export
{ * }
