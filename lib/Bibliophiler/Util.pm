package Bibliophiler::Util;

use strict;
use warnings;
use 5.010;

use FindBin;
use lib "$FindBin::Bin/../lib";

use Bibliophiler::Schema;

sub get_schema {
  return Bibliophiler::Schema->connect( "dbi:SQLite:$FindBin::Bin/../db/bibliophiler.db" );
}

1;

