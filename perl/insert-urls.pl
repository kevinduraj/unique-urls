#!/usr/bin/perl
#-----------------------------------------------------------------------#
use Time::HiRes qw ( time alarm sleep );
use IO::Async::Loop;
use Net::Async::CassandraCQL;
use Protocol::CassandraCQL qw( CONSISTENCY_QUORUM );
$| = 1;

my $loop = IO::Async::Loop->new;
my $cass = Net::Async::CassandraCQL->new(
   host => "192.168.1.159",
   keyspace => "engine1",
   default_consistency => CONSISTENCY_QUORUM,
);

$loop->add( $cass );
$cass->connect->get;
 
my @f;
my $filename = '/home/temp/visited_37.dat';

open(my $fh, $filename) or die "Could not open file '$filename' $!";

while (my $row = <$fh>) {

  $i++;

  chomp $row;
  next if $row =~ /(\'|\[|\%)/; 
  next if length($row) < 10;
  next if length($row) > 200;;
  #next if $i < 1_500_000; 

  # 1 Months TTL = 2592000
  # 2 Months TTL = 5184000 
  # 3 Months TTL = 7776000 
  # 6 Months TTL = 15552000
  my $range   = 15552000;
  my $minimum =  5184000;
  my $random_number = int(rand($range)) + $minimum;
 
  my $SQL = "INSERT INTO engine1.visited (url) VALUES ('$row') USING TTL $random_number;";
  push @f, $cass->query( $SQL );

  if ($i % 10000 == 0) {

      print $i . " " . $SQL . "\n";
      Future->needs_all( @f )->get;
      @f=(); 
      #sleep 1;
  }

}
#-----------------------------------------------------------------------#

