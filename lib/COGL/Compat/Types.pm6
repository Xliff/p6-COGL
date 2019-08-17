use v6.c;

use NativeCall;

unit package COGL::Compat::Types;

constant MirSurface       is export := Pointer;
constant wl_shell_surface is export := Pointer;
constant wl_surface       is export := Pointer;
constant HWND             is export := Pointer; # Win32
constant gdl_plane_id_t   is export := uint32; # Best guess at enum type.
