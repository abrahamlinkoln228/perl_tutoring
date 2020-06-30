
#!/usr/bin/perl

use File::Find;
#use Pod::HTML;
use File::Spec;
use File::Path qw( make_path );

sub pod2html {

#  print $_;

  my $htm_s ='
	<!DOCTYPE html>
	<html lang="en">
	<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
	</head>
	<body>	
  ';

  my $htm_e = '
	
	</body>
	</html>
  ';

  my $src = $_;
  my $dir = '/var/www/html/work/structred/4/docu/';

  my $des = $dir.$src.".html";


  if ( !-d $dir ) {
    make_path $dir or die "Failed to create path: $directories";
  }

  my $perldoc_out = `pod2html $src`;

#  open(SRC,'<',$src) or die $!;
  open(DES,'>',$des) or die $!;

  print("copying content from $src to $des\n");
  print("\n");
#  print DES "Content-Type: text/html\n\n";
#  print DES $htm_s;
#  while(<SRC>){
#    print DES $_;
#    print DES "<br>";	
#  }
  print DES $perldoc_out; 
#  print DES $htm_e;


  #close(SRC);
  close(DES);

#      open my $in, "<:encoding(utf8)", $des or die "$file: $!";
#    my @lines = <$in>;
#    close $in;
     
#    chomp @lines;
#    for my $line (@lines) {
      #print $line;
      #print "\n";
#      if($line =~ /\^\[\[1m.*\^\[\[0m/){
#	  print $line;
#	} else {
#		print "hello";
#	}

#      if($line =~ //)
#    }

#         print scalar @lines;



}

sub eachFile {
  my $filename = $_;
  my $fullpath = $File::Find::name;
  #remember that File::Find changes your CWD, 
  #so you can call open with just $_

  if (rindex($filename, '.pm') != -1) {
	
	if(rindex($filename =~ /[a-zA-Z]+.pm/, "documntation" )) {
		#our $out = `/usr/bin/perldoc $fullpath. > $fullpath.documentation`;
		#my $abs_path = File::Spec->rel2abs( $filename ) ;
		#pod2html($filepath);
		my $size = -s $filename;
		if($size != 0) {
			pod2html($filepath);
		}
		#print $fullpath;
		#print "\n";			
	
	}
 
	#print($filename);
	#print($fullpath);
	#print("\n");
 }
}

find (\&eachFile, "/usr/abills/");
