use v6.c;

unit package COGL::Raw::Exports;

our @cogl-exports is export;

BEGIN {
  @cogl-exports = <
    COGL::Raw::Definitions
    COGL::Raw::Enums
    COGL::Raw::Structs
    COGL::Compat::Types
  >;
}
