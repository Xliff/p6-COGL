use v6.c;

use NativeCall;

unit package COGL::Compat::Types;

constant MirSurface       is export := Pointer;
constant wl_shell_surface is export := Pointer;
constant wl_surface       is export := Pointer;
constant HWND             is export := Pointer; # Win32
