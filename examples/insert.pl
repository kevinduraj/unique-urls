#!/usr/bin/perl
use strict;
use warnings;
use perlcassa::Binary::Socket;
use perlcassa::Binary::Pack;
use perlcassa::Util;
use AnyEvent;
use Data::Dumper;
#----------------------------------------------------------------------------------------------------#
my $obj = new perlcassa::Binary::Socket(
	server => "127.0.0.1",
	#port => 9042 #optional, defaults to 9042
);
#----------------------------------------------------------------------------------------------------#

# Sync
$obj->query_sync("INSERT INTO kevin.test (id, first_name, last_name) VALUES (1, 'Kevin', 'Thomas')", "ONE");
$obj->query_sync("SELECT * FROM kevin.test WHERE id = 1", "ONE", \&example_callback);

# Async
for(my $i = 2; $i < 100_000; $i++) {

  my $first_name = generate_random_string(7);
  my $last_name  = generate_random_string(7);

  my $SQL1 = "INSERT INTO kevin.test (id, first_name, last_name) VALUES ($i, '$first_name', '$last_name'); ";
  my $SQL2 = "SELECT * FROM kevin.test WHERE id = $i; ";

  $obj->query_sync($SQL1, "ONE");

  if (($i % 1000) == 0)  {
     print $SQL1 . "\n";
     $obj->query_sync($SQL2, "ONE", \&example_callback);
  }
}

$obj->submit();

#----------------------------------------------------------------------------------------------------#
sub example_callback() {
	my $result = shift;
	print Dumper($result);
}
#----------------------------------------------------------------------------------------------------#
sub generate_random_string
{
	my $length_of_randomstring=shift;# the length of 
			 # the random string to generate

	my @chars=('a'..'z','A'..'Z','0'..'9','_');
	my $random_string;
	foreach (1..$length_of_randomstring) 
	{
		# rand @chars will generate a random 
		# number between 0 and scalar @chars
		$random_string.=$chars[rand @chars];
	}
	return $random_string;
}
#----------------------------------------------------------------------------------------------------#
