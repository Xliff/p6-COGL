use v6.c;

use GTK::Compat::Types;
use COGL::Raw::Types;
use COGL::Raw::Pipeline;

class COGL::Pipeline {
  has CoglPipeline $!cp;
  
  method new {
    cogl_pipeline_new();
  }
  
  method cogl_is_pipeline {
    cogl_is_pipeline($!cp);
  }

  method copy {
    cogl_pipeline_copy($!cp);
  }

  method foreach_layer (
    CoglPipelineLayerCallback $callback, 
    gpointer $user_data = gpointer
  ) {
    cogl_pipeline_foreach_layer($!cp, $callback, $user_data);
  }

  method get_gtype {
    cogl_pipeline_get_gtype($!cp);
  }

  method get_uniform_location (Str $uniform_name) {
    cogl_pipeline_get_uniform_location($!cp, $uniform_name);
  }
  
}
