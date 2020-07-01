#!/usr/local/bin/perl

=head1 NAME

  This file perform connection to mysql database and returns all results from abonents table  

=cut

use CGI qw(:standard);
use DBI;

my $host = "localhost";
my $port = "3306";
my $user = "phpmyadmin";
my $pass = "phpmyadmin";
my $db = "abonents";

my $request = param("n1");

$dbh = DBI->connect("DBI:mysql:$db:$host:$port",$user,$pass);
$sth = $dbh->prepare("SELECT * FROM abonents");
$sth->execute; # исполняем запрос
print "Content-Type: text/html\n\n";
while ($ref = $sth->fetchrow_arrayref) {

  #here we need to verify db output variables, but in this scenario well assume that evrything is not empty

  print "$$ref[0] "; # печатаем результат
  print "$$ref[1] "; # печатаем результат
  print "$$ref[2] "; # печатаем результат

  print "|d"; #one raw delimeter 
} 
print "|end";

$rc = $sth->finish;
$rc = $dbh->disconnect; 

1;
