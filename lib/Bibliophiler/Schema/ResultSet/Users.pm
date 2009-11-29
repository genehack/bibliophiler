package Bibliophiler::Schema::ResultSet::Users;

use strict;
use warnings;
use 5.010;

use base 'DBIx::Class::ResultSet';

use Digest;
use Mail::VRFY;

1;
