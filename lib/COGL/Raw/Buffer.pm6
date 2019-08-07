use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;

unit package COGL::Raw::Buffer;

sub cogl_is_buffer (void $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_buffer_get_size (CoglBuffer $buffer)
  returns int
  is native(cogl)
  is export
{ * }

sub cogl_buffer_map (
  CoglBuffer $buffer, 
  CoglBufferAccess $access, 
  CoglBufferMapHint $hints
)
  is native(cogl)
  is export
{ * }

sub cogl_buffer_map_range (
  CoglBuffer $buffer, 
  size_t $offset, 
  size_t $size, 
  CoglBufferAccess $access, 
  CoglBufferMapHint $hints, 
  CArray[Pointer[CoglError]]
)
  is native(cogl)
  is export
{ * }

sub cogl_buffer_set_data (
  CoglBuffer $buffer, 
  size_t $offset, 
  Pointer $data, 
  size_t $size
)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_buffer_unmap (CoglBuffer $buffer)
  is native(cogl)
  is export
{ * }

sub cogl_buffer_get_update_hint (CoglBuffer $buffer)
  returns CoglBufferUpdateHint
  is native(cogl)
  is export
{ * }

sub cogl_buffer_set_update_hint (
  CoglBuffer $buffer, 
  CoglBufferUpdateHint $hint
)
  is native(cogl)
  is export
{ * }
