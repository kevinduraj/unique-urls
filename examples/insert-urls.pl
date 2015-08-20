#!/usr/bin/perl
#-----------------------------------------------------------------------#
use Time::HiRes qw ( time alarm sleep );
use IO::Async::Loop;
use Net::Async::CassandraCQL;
use Protocol::CassandraCQL qw( CONSISTENCY_QUORUM );
$| = 1;

my $loop = IO::Async::Loop->new;
my $cass = Net::Async::CassandraCQL->new(
   host => "127.0.0.1",
   keyspace => "engine35",
   default_consistency => CONSISTENCY_QUORUM,
);

$loop->add( $cass );
$cass->connect->get;
 
my @f;
my $filename = '/home/spider/raw/log/all-08-18.log';

open(my $fh, $filename) or die "Could not open file '$filename' $!";

while (my $row = <$fh>) {

  $i++;

  chomp $row;
  next if $row =~ /(\'|\[|\%)/; 
  next if length($row) < 10;
  next if $i < 3847000;

  my $SQL = "INSERT INTO engine35.table2 (url) VALUES ('$row')";
  print $i . " " . $SQL . "\n" if ($i % 1000 == 0);
  push @f, $cass->query( $SQL );

  if ($i % 1000 == 0) {
      Future->needs_all( @f )->get;
      @f=(); 
      sleep 0.1;
  }

}
#-----------------------------------------------------------------------#

