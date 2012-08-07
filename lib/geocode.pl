#!/usr/bin/perl

use strict;
use Geo::Coder::US;
use Data::Dumper qw/Dumper/;
use Getopt::Long;

my ($result, $file, $db);

$db = $ENV{PWD}."/db/geocoder.db";
$result = GetOptions (
  "file=s"   => \$file,
  "db=s"     => \$db
);

Geo::Coder::US->set_db( $db );

open FILE, "<$file"
  or die "Error: $file: $!\n";
while (my $line = <FILE>) {
  chomp($line);
  my @addrs = Geo::Coder::US->geocode($line);
  my $address = look_for_latlon(\@addrs);
  if (not defined $address and $line =~ /(\d\d\d\d\d)/) {
    @addrs = Geo::Coder::US->geocode($1);
    $address = look_for_latlon(\@addrs);
  }
  print join("\t", $address->{'lat'}, $address->{'long'}, $line), "\n" if defined $address->{'long'};
}
close FILE;

sub look_for_latlon {
  my $results = shift();
  foreach (@$results) {
    return $_ if exists $_->{'long'};
  }
  return $results->[0] if scalar(@$results) > 0;
  return undef;
}
