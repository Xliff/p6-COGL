use v6;

use GLib::Raw::Exports;
use COGL::Raw::Exports;

unit package COGL::Raw::Types;

need GLib::Raw::Debug;
need GLib::Raw::Definitions;
need GLib::Raw::Enums;
need GLib::Raw::Exceptions;
need GLib::Raw::Object;
need GLib::Raw::Structs;
need GLib::Raw::Subs;
need GLib::Raw::Struct_Subs;
need GLib::Roles::Pointers;
need GLib::Roles::Implementor;
need COGL::Raw::Definitions;
need COGL::Raw::Enums;
need COGL::Raw::Structs;
need COGL::Compat::Types;

BEGIN {
  glib-re-export($_) for |@glib-exports,
                         |@cogl-exports;
}
