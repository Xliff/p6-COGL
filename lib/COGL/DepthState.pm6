use v6.c;

use GTK::Raw::Utils;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::DepthState;

class COGL::DepthState {
  has CoglDepthState $!cds;
  
  submethod BUILD (CoglDepthState :$depth) {
    $!cds = $depth;
  }
  
  method COGL::Raw::Types::CoglDepthState 
  { $!cds }
  
  method new {
    self.bless( depth => COGL::DepthState.init( CoglDepthState.new ) )
  }
  
  method test_enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        so cogl_depth_state_get_test_enabled($!cds);
      },
      STORE => sub ($, Int() $enable is copy) {
        my gboolean $e = resolve-bool($enable);
        
        cogl_depth_state_set_test_enabled($!cds, $enable);
      }
    );
  }

  method test_function is rw {
    Proxy.new(
      FETCH => sub ($) {
        CoglDepthTestFunction( cogl_depth_state_get_test_function($!cds) );
      },
      STORE => sub ($, Int() $function is copy) {
        my guint $f = resolve-uint($function);
        
        cogl_depth_state_set_test_function($!cds, $f);
      }
    );
  }

  method write_enabled is rw {
    Proxy.new(
      FETCH => sub ($) {
        so cogl_depth_state_get_write_enabled($!cds);
      },
      STORE => sub ($, Int() $enable is copy) {
        my gboolean $e = resolve-bool($enable);
        
        cogl_depth_state_set_write_enabled($!cds, $e);
      }
    );
  }
  
  method get_range (Num() $near_val, Num $far_val) {
    my gfloat ($nv, $fv) = ($near_val, $far_val);
    
    cogl_depth_state_get_range($!cds, $near_val, $far_val);
  }

  method init (COGL::DepthState:U: CoglDepthState $slate) {
    cogl_depth_state_init($slate);
    $slate;
  }

  method set_range (Num() $near_val, Num $far_val) {
    my gfloat ($nv, $fv) = ($near_val, $far_val);
    
    cogl_depth_state_set_range($!cds, $near_val, $far_val);
  }

}
