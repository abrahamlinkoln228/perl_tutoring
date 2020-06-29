
#!/usr/bin/perl

use File::Find;
#use Pod::HTML;
use File::Spec;


sub pod2html {

#  print $_;

  my $src = $_;
  my $des = "/usr/abills/documentation/".$src.".html";

  open(SRC,'<',$src) or die $!;

  open(DES,'>',$des) or die $!;

  print("copying content from $src to $des\n");
  print("\n");
  while(<SRC>){
    print DES $_;	
  }

  # always close the filehandles
  close(SRC);
  close(DES);

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
		pod2html($filepath);
		#print $fullpath;
		#print "\n";			
	
	}
 
	#print($filename);
	#print($fullpath);
	#print("\n");
 }
}

find (\&eachFile, "/usr/abills/");
