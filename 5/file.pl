#!/usr/bin/perl -w

use strict;
use CGI;
use CGI::Carp qw ( fatalsToBrowser );
use File::Basename;
use CGI qw(:standard);
use DBI;

my $host = "localhost";
my $port = "3306";
my $user = "phpmyadmin";
my $pass = "phpmyadmin";
my $db = "abonents";


$CGI::POST_MAX = 1024 * 5000;
my $safe_filename_characters = "a-zA-Z0-9_.-";
my $upload_dir = "/var/www/html/work/structred/5/img";

my $query = new CGI;
my $filename = $query->param("photo");
my $id = $query->param("id");

if ( !$filename )
{
print $query->header ( );
print "There was a problem uploading your photo (try a smaller file).";
exit;
}

my ( $name, $path, $extension ) = fileparse ( $filename, '..*' );
$filename = $name . $extension;
$filename =~ tr/ /_/;
$filename =~ s/[^$safe_filename_characters]//g;

if ( $filename =~ /^([$safe_filename_characters]+)$/ )
{
$filename = $1;
}
else
{
die "Filename contains invalid characters";
}

my $upload_filehandle = $query->upload("photo");

open ( UPLOADFILE, ">$upload_dir/$filename" ) or die "$!";
binmode UPLOADFILE;

while ( <$upload_filehandle> )
{
print UPLOADFILE;
}

close UPLOADFILE;

my $dbh = DBI->connect("DBI:mysql:$db:$host:$port",$user,$pass);
my $sth = $dbh->prepare("UPDATE `abonents` SET `img_abonent` = './img/".$filename."' WHERE `abonents`.`id_abonent` = ".$id.";");
 $sth->execute; # исполняем запрос


$sth->finish;
$dbh->disconnect; 

print $query->header ( );
print <<END_HTML;
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Thanks!</title>
<style type="text/css">
img {border: none;}
</style>
</head>
<body>
<p>Thanks for uploading your photo!</p>
<p>Your photo id: $id</p>
<p>Your photo:</p>
<p><img src="/upload/$filename" alt="Photo" /></p>
</body>
</html>
END_HTML
