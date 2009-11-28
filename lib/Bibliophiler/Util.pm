package Bibliophiler::Util;

use strict;
use warnings;
use 5.010;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Bibliophiler::Schema;

sub db_path { "$FindBin::Bin/../db/bibliophiler.db" }

sub get_resultset {
  my( $package , $name ) = @_;
  my $schema = $package->get_schema;
  return $schema->resultset( $name );
}

sub get_schema {
  my( $package ) = @_;
  my $db = $package->db_path;
  return Bibliophiler::Schema->connect( "dbi:SQLite:$db" );
}

1;
