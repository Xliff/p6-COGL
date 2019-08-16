use v6.c;

use GTK::Compat::Roles::TypedBuffer;

sub MAIN {
  my $v = 0; 
  my $triangle = GTK::Compat::TypedBuffer[CoglVertedp2C4].new( size => 3 );
  $triangle.bind($v++, CoglVertexP2C4.new( |$_ ) for 
    [   0,  0.7, 0xff, 0x00, 0x00, 0xff],
    [-0.7, -0.7, 0x00, 0xff, 0x00, 0xff],
    [ 0.7, -0.7, 0x00, 0x00, 0xff, 0xff];
  
  my $onscreen = COGL::Onscreen.new;
  
