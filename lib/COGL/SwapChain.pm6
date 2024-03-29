use v6.c;

use Method::Also;
use NativeCall;

use COGL::Raw::Types;

class COGL::SwapChain {
  has CoglSwapChain $!csc;
  has %!attr;

  submethod BUILD (:$chain) {
    $!csc = $chain;
  }

  method COGL::Raw::Definitions::CoglSwapChain
    is also<CoglSwapChain>
  { $!csc }

  multi method new (CoglSwapChain $chain) {
    $chain ?? self.bless(:$chain) !! Nil;
  }
  multi method new {
    my $chain = cogl_swap_chain_new();

    $chain ?? self.bless(:$chain) !! Nil;
  }

  proto method is_swap_chain (|)
    is also<is-swap-chain>
  { * }

  multi method is_swap_chain {
    COGL::SwapChain.is_swap_chain($!csc);
  }
  multi method is_swap_chain (COGL::SwapChain:U: Pointer $candidate) {
    return False unless $candidate;

    so cogl_is_swap_chain($candidate);
  }

  method get_gtype is also<get-gtype> {
    state ($n, $t);

    unstable_get_type( self.^name, &cogl_swap_chain_get_gtype, $n, $t );
  }

  method set_has_alpha (Int() $has_alpha) is also<set-has-alpha> {
    my gboolean $a = %!attr<has-alpha> = $has_alpha.so.Int;

    cogl_swap_chain_set_has_alpha($!csc, $a);
  }

  method set_length (Int() $length) is also<set-length> {
    my gboolean $l = %!attr<length> = $length.so.Int;

    cogl_swap_chain_set_length($!csc, $l);
  }

  method has_alpha is rw is also<has-alpha> {
    Proxy.new:
      FETCH => sub ($)            { %!attr<has-alpha> },
      STORE => -> $, Int() $ha { self.set_has_alpha($ha) };
  }

  method length is rw {
    Proxy.new:
      FETCH => sub ($)           { %!attr<length> },
      STORE => -> $, Int() $l { self.set_length($l) };
  }

}

sub cogl_is_swap_chain (Pointer $object)
  returns CoglBool
  is native(cogl)
  is export
{ * }

sub cogl_swap_chain_get_gtype ()
  returns GType
  is native(cogl)
  is export
{ * }

sub cogl_swap_chain_new ()
  returns CoglSwapChain
  is native(cogl)
  is export
{ * }

sub cogl_swap_chain_set_has_alpha (
  CoglSwapChain $swap_chain,
  CoglBool      $has_alpha
)
  is native(cogl)
  is export
{ * }

sub cogl_swap_chain_set_length (CoglSwapChain $swap_chain, guint $length)
  is native(cogl)
  is export
{ * }
