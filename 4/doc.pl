#!/usr/bin/perl

=head1 NAME

  File generates documentation of all documented files for abils in HTML format

=cut


use strict;
use warnings;

use File::Find;
use File::Spec;
use File::Path qw( make_path );

#**********************************************************
=head2 pod2html($filepath) - generates docs for file 
 
  Arguments:
    $filepath   - path to the file 
 
  Returns:
   TRUE or FALSE
 
  Example:
 
    pod2html("/usr/test.pm");
 
=cut
#**********************************************************
sub pod2html {

  my $src = $_;
  my $dir = '/var/www/html/work/structred/4/docu/';
  my $des = $dir.$src.".html";

  if ( !-d $dir ) {
    make_path $dir or die "Failed to create path: $dir";
  }

  my $perldoc_out = `pod2html $src`;

  open(my $DES,'>',$des) or die $!;
  print("copying content from $src to $des\n");
  print("\n");
  print $DES $perldoc_out; 
  close($DES);

  return 1;
}


#**********************************************************
=head2 each_file($filename) - Check the size and type of file
 
  Arguments:
    $filename   - exact path to file
 
  Returns:
   TRUE
 
  Example:

   find (\&each_file, "/usr/abills/"); 
 
=cut
#**********************************************************
sub each_file {
  my $filename = $_;
  my $fullpath = $File::Find::name;

  if (rindex($filename, '.pm') != -1) {

    if(rindex($filename =~ /[a-zA-Z]+.pm/, "documntation" )) {
      my $size = -s $filename;
      if($size != 0) {
        pod2html($fullpath);
      }	
    }
  }

  return 1;
}

find (\&each_file, "/usr/abills/");

1;
