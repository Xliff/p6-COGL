use v6.c;

use NativeCall;


use COGL::Raw::Types;

unit package COGL::Raw::DepthState;

sub cogl_depth_state_get_range (
  CoglDepthState $state,
  gfloat         $near_val,
  gfloat         $far_val
)
  is native(cogl)
  is export
{ * }

sub cogl_depth_state_init (CoglDepthState $state)
  is native(cogl)
  is export
{ * }

sub cogl_depth_state_set_range (
  CoglDepthState $state,
  gfloat         $near_val,
  gfloat         $far_val
)
  is native(cogl)
  is export
{ * }

sub cogl_depth_state_get_test_enabled (CoglDepthState $state)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_depth_state_get_test_function (CoglDepthState $state)
  returns guint # CoglDepthTestFunction
  is native(cogl)
  is export
{ * }

sub cogl_depth_state_get_write_enabled (CoglDepthState $state)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_depth_state_set_test_enabled (
  CoglDepthState $state,
  CoglBool       $enable
)
  is native(cogl)
  is export
{ * }

sub cogl_depth_state_set_test_function (
  CoglDepthState $state,
  guint          $function # CoglDepthTestFunction $function
)
  is native(cogl)
  is export
{ * }

sub cogl_depth_state_set_write_enabled (
  CoglDepthState $state,
  CoglBool       $enable
)
  is native(cogl)
  is export
{ * }
