#!/usr/bin/perl

use strict;
use warnings;
use perlcassa::Binary::Socket;
use perlcassa::Binary::Pack;
use perlcassa::Util;
use AnyEvent;

my $obj = new perlcassa::Binary::Socket(
	server => "127.0.0.1",
	#port => 9042 #optional, defaults to 9042
);

#use sync
$obj->query_sync("SELECT * FROM kevin.test", "ONE", \&example_callback);
#$obj->query_sync("SELECT * FROM kevin.test WHERE id = 852468", "ONE", \&example_callback);

# use async
for(my $i = 0; $i < 2; $i++) {

	$obj->query("SELECT * FROM kevin.test", "ONE", \&example_callback);
	#$obj->query("SELECT * FROM kevin.test WHERE id = 852468", "ONE", \&example_callback);
}

$obj->submit();


sub example_callback() {
	my $result = shift;

	use Data::Dumper;
	print Dumper($result);
}
