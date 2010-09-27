#! /opt/perl/bin/perl

use strict;
use warnings;

use YAML qw/ LoadFile Dump /;

my $yaml = LoadFile( './readings-2008.yml' );

my @yaml;
foreach my $key ( sort { $a <=> $b } keys %$yaml ) {
  push @yaml , $yaml->{$key};
}

print Dump( \@yaml );

